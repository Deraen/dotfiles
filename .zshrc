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

# Search history
bindkey '^R' history-incremental-search-backward

# Backward delete to slash
autoload -U select-word-style
select-word-style bash

# Ctrl + left/right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Automatically escape ?&= on urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Complete .. -> ../
zstyle ':completion:*' special-dirs true
# Show some colors on complete
zstyle ':completion:*' list-colors ''

# Load common shell options
source $HOME/.config/terminal/common.sh

# Color commands
source $HOME/.local/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
