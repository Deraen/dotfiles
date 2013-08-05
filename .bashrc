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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias apt-add-key='apt-key adv --keyserver keyserver.ubuntu.com --recv-keys '
alias ccze="ccze -A"

export DEBFULLNAME="Juho Teperi"
export DEBEMAIL="juho.teperi@iki.fi"
export EDITOR="nano"
export MOST_EDITOR="nano"
export PAGER="most"
export LESS="-R"

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

addPath "$HOME/.local/bin"
addPath /raid/opt/modelsim/modelsim_ase/linux
addPath /raid/opt/android-sdk-linux_x86/platform-tools
addPath /raid/opt/android-sdk-linux_x86/tools
addPath /raid/opt/android-ndk
addPath /opt/modelsim/modelsim_ase/linux
addPath /opt/android-sdk-linux_x86/platform-tools
addPath "/Applications/Android Studio.app/sdk/platform-tools"
addPath /opt/android-sdk-linux_x86/tools
addPath "/Applications/Android Studio.app/sdk/tools"
addPath /opt/android-ndk
addPath "$HOME/.rvm/bin"
addPath "/usr/local/heroku/bin"

addSource "$HOME/.local/share/liquidprompt/liquidprompt"
LP_BRACKET_OPEN=""
LP_BRACKET_CLOSE=""

addSource "$HOME/.pythonbrew/etc/bashrc"
addSource "$HOME/.rvm/scripts/rvm"

# Home git repo, don't show untracked files on status
cd $HOME && git config status.showUntrackedFiles no
