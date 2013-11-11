[ -z "$PS1" ] && return

HISTCONTROL=ignoredups:ignorespace

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias apt-add-key='apt-key adv --keyserver keyserver.ubuntu.com --recv-keys '
alias ccze="ccze -A"
alias o="open.sh"

export DEBFULLNAME="Juho Teperi"
export DEBEMAIL="juho.teperi@iki.fi"
export EDITOR="vim"
export MOST_EDITOR="vim"
export PAGER="less"

export TERM="rxvt-unicode-256color"
if [ "$HOSTNAME" = "alpha-144.srv.hosting.fi" ]; then
    export TERM="xterm"
fi

LP_BRACKET_OPEN=""
LP_BRACKET_CLOSE=""

export npm_config_prefix="$HOME/.local"

function exportIfExists {
    [[ -d "$2" ]] && export "$1"="$2"
}

exportIfExists ANDROID_HOME "/raid/opt/android-sdk-linux_x86"
exportIfExists ANDROID_HOME "/opt/android-sdk-linux_x86"
exportIfExists ANDROID_HOME "$HOME/.local/android-sdk"

function addPath {
    [[ -d "$1" ]] && export PATH="$1:$PATH"
}

function addSource {
    [[ -s "$1" ]] && source "$1"
}

addPath "$HOME/bin"
addPath "$HOME/.local/bin"
addPath "$HOME/.cabal/bin"
addPath /raid/opt/android-sdk-linux_x86/platform-tools
addPath /raid/opt/android-sdk-linux_x86/tools
addPath /raid/opt/android-ndk
addPath /opt/android-sdk-linux_x86/platform-tools
addPath /opt/android-sdk-linux_x86/tools
addPath /opt/android-ndk
addPath "/Applications/Android Studio.app/sdk/platform-tools"
addPath "/Applications/Android Studio.app/sdk/tools"
addPath "$HOME/.rvm/bin"
addPath "/usr/local/heroku/bin"

addSource "$HOME/.pythonbrew/etc/bashrc"
addSource "$HOME/.rvm/scripts/rvm"

# Home git repo, don't show untracked files on status
cd $HOME && git config status.showUntrackedFiles no

source /home/juho/.local/tpm/.config
