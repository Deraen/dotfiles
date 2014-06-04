export ZSH=$HOME/.local/tpm/oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git git-flow)

source $ZSH/oh-my-zsh.sh

. /home/juho/.config/terminal/common.sh

# Complete .. -> ../
zstyle ':completion:*' special-dirs true
