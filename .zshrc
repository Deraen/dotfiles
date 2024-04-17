# zmodload zsh/zprof

# Load bash completion support
autoload -U +X bashcompinit && bashcompinit

fpath=( \
    "$HOME/.config/terminal/zfunctions" \
    "$HOME/.local/modules/zsh-completions/src" \
    "$HOME/.local/modules/oh-my-zsh/plugins/gitfast" \
    $fpath )

# Use history
HISTFILE=$HOME/.zsh_history

# Load Pure prompt
autoload -U promptinit && promptinit
PURE_GIT_PULL=0
PURE_GIT_UNTRACKED_DIRTY=0
prompt pure

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

export FZF_DEFAULT_OPTS="--bind=tab:accept"
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'
# Fzf-tab should be initialized after compinit, but before other possible plugins which wrap widgets
[[ -f /home/juho/.local/modules/fzf-tab/fzf-tab.plugin.zsh ]] && source /home/juho/.local/modules/fzf-tab/fzf-tab.plugin.zsh

# You can use bindkey to view current bindings, with -M to select the keymap
# Search history
bindkey '^R' history-incremental-search-backward

bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete
bindkey '^k' up-history
bindkey '^j' down-history
# These are already defaults
# bindkey '^h' backward-delete-char
# bindkey '^w' backward-kill-word
# bindkey '^r' history-incremental-search-backward

zmodload zsh/complist
# NOTE: zsh-tab overrides regular tab-completion, but ^f does work if needed.
# Replace next-char binding to trigger menu-complete widget
bindkey '^f' menu-complete
# Enable tab etc. to use menu-complete widget instead of list
set menu_complete
# Enable search in menuselect -
# these both init the search and are used to go forward/backards in the search results.
bindkey -M menuselect '^F' history-incremental-search-forward
bindkey -M menuselect '^R' history-incremental-search-backward

# Backward delete to slash
autoload -U select-word-style
select-word-style bash

# Ctrl + left/right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Automatically escape ?&= on urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Load common shell options
source $HOME/.config/terminal/common.sh

# Complete .. -> ../
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache on
# zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

# Color commands
source $HOME/.local/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zprof
