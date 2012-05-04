# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ "$USERNAME" = "root" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[31m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias apt-add-key='apt-key adv --keyserver keyserver.ubuntu.com --recv-keys '

export EDITOR="nano"
export MOST_EDITOR="nano"
export PAGER="most"
export LESS="-R"
alias ccze="ccze -A"

if [ "$HOSTNAME" = "juho-desktop" ]; then
    PATH="/raid/opt/modelsim/modelsim_ase/linux:/raid/opt/android-sdk-linux_x86/platform-tools:/raid/opt/android-sdk-linux_x86/tools:$PATH"
elif [[ "$HOSTNAME" = "juho-laptop" ]]; then
    PATH="/opt/modelsim/modelsim_ase/linux:/opt/android-sdk-linux_x86/platform-tools:/opt/android-sdk-linux_x86/tools:$PATH"
fi

export DEBFULLNAME="Juho Teperi"
export DEBEMAIL="juho.teperi@tut.fi"

alias tutg++='g++'
