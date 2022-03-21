# zmodload zsh/zprof

NVM_LAZY=1

fpath=( \
    "$HOME/.config/terminal/zfunctions" \
    "$HOME/.local/modules/zsh-completions/src" \
    "$HOME/.local/modules/oh-my-zsh/plugins/gitfast" \
    "$HOME/.local/modules/oh-my-zsh/plugins/nvm" \
    $fpath )

# plugin folder in fpath for nvm completion
# load the plugin for lazy-load nvm setup
source $HOME/.local/modules/oh-my-zsh/plugins/nvm/nvm.plugin.zsh

# Use history
HISTFILE=$HOME/.zsh_history

# Load Pure prompt
autoload -U promptinit && promptinit
PURE_GIT_PULL=0
PURE_GIT_UNTRACKED_DIRTY=0
prompt pure

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
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache"

# Color commands
source $HOME/.local/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

# Automatically enable node version from .zshrc file when entering a directory
load-nvmrc() {
    # nvm version read is only inside if and elif branches,
    # so if nvnrc doesn't exist and nvm wasn't enabled nvm version isn't run.
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [[ -n "$nvmrc_path" ]]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [[ "$nvmrc_node_version" = "N/A" ]]; then
            nvm install
        elif [[ "$nvmrc_node_version" != "$(nvm version)" ]]; then
            nvm use
        fi
    # Extra NVM_BIN check to only revert to default version if nvm was
    # already loaded by entering a dir with .nvmrc or by running npm/node command.
    # Else this would run for all new sessions.
    elif [[ -n "$NVM_BIN" ]] && [[ "$(nvm version)" != "$(nvm version default)" ]]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd load-nvmrc

load-nvmrc

# zprof
