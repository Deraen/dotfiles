export ZSH=$HOME/.local/modules/oh-my-zsh

ZSH_THEME="deraen"
DISABLE_AUTO_UPDATE="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.config/terminal/oh-my-zsh

plugins=(git git-flow)

source $ZSH/oh-my-zsh.sh

. /home/juho/.config/terminal/common.sh

# Complete .. -> ../
zstyle ':completion:*' special-dirs true
