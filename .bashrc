[ -z "$PS1" ] && return

HISTCONTROL=ignoredups:ignorespace

shopt -s histappend
shopt -s checkwinsize

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

. /home/juho/.config/terminal/common.sh
