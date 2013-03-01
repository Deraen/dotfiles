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

PATH="/home/juho/.local/bin:$PATH"

if [ "$HOSTNAME" = "juho-desktop" ]; then
    PATH="/raid/opt/modelsim/modelsim_ase/linux:/raid/opt/android-sdk-linux_x86/platform-tools:/raid/opt/android-sdk-linux_x86/tools:/raid/opt/android-ndk/:$PATH"
elif [[ "$HOSTNAME" = "juho-laptop" ]]; then
    PATH="/opt/modelsim/modelsim_ase/linux:/opt/android-sdk-linux_x86/platform-tools:/opt/android-sdk-linux_x86/tools:/opt/android-ndk/:$PATH"
fi

export DEBFULLNAME="Juho Teperi"
export DEBEMAIL="juho.teperi@tut.fi"

alias tutg++='g++'

extract () {
  if [ $# -ne 1 ]
  then
    echo "Error: No file specified."
    return 1
  fi
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1   ;;
            *.tar.gz)  tar xvzf $1   ;;
            *.bz2)     bunzip2 $1    ;;
            *.rar)     unrar x $1    ;;
            *.gz)      gunzip $1     ;;
            *.tar)     tar xvf $1    ;;
            *.tbz2)    tar xvjf $1   ;;
            *.tgz)     tar xvzf $1   ;;
            *.zip)     unzip $1      ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1       ;;
            *)         echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

function __256fg {
    echo "\033[38;5;${1}m"
}

function __256bg {
    echo "\033[48;5;${1}m"
}

THEME_PROMPT_HOST='\H'
SCM_THEME_PROMPT_DIRTY='*'
SCM_THEME_PROMPT_CLEAN=''
#SCM_THEME_PROMPT_PREFIX="$(__256bg 88)$(__256fg 39)⮀$(__256bg 88)$(__256fg 210) "
#SCM_THEME_PROMPT_SUFFIX=" ${Color_Off}$(__256fg 88)"
SCM_THEME_PROMPT_PREFIX=" ("
SCM_THEME_PROMPT_SUFFIX=")"

SCM_GIT='git'
SCM_GIT_CHAR='±'

VIRTUALENV_THEME_PROMPT_PREFIX=' |'
VIRTUALENV_THEME_PROMPT_SUFFIX='|'

function git_prompt_vars {
  if [[ -n $(git status -s 2> /dev/null |grep -v ^# |grep -v "working directory clean") ]]; then
    SCM_DIRTY=1
     SCM_STATE=${GIT_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
  else
    SCM_DIRTY=0
     SCM_STATE=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
  fi
  SCM_PREFIX=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  SCM_SUFFIX=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  SCM_BRANCH=${ref#refs/heads/}
  SCM_CHANGE=$(git rev-parse HEAD 2>/dev/null)
}

function virtualenv_prompt {
  if which virtualenv &> /dev/null; then
    virtualenv=$([ ! -z "$VIRTUAL_ENV" ] && echo "`basename $VIRTUAL_ENV`") || return
    echo -e "$VIRTUALENV_THEME_PROMPT_PREFIX$virtualenv$VIRTUALENV_THEME_PROMPT_SUFFIX"
  fi
}


function scm {
  if [[ -f .git/HEAD ]]; then SCM=$SCM_GIT
  elif [[ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]]; then SCM=$SCM_GIT
  elif [[ -d .hg ]]; then SCM=$SCM_HG
  elif [[ -n "$(hg root 2> /dev/null)" ]]; then SCM=$SCM_HG
  elif [[ -d .svn ]]; then SCM=$SCM_SVN
  else SCM=$SCM_NONE
  fi
}

function scm_prompt_char {
  if [[ -z $SCM ]]; then scm; fi
  if [[ $SCM == $SCM_GIT ]]; then SCM_CHAR=$SCM_GIT_CHAR
  else SCM_CHAR=$SCM_NONE_CHAR
  fi
}

function scm_prompt_vars {
  scm
  scm_prompt_char
  SCM_DIRTY=0
  SCM_STATE=''
  [[ $SCM == $SCM_GIT ]] && git_prompt_vars && return
}

function scm_prompt_info {
  scm
  scm_prompt_char
  SCM_DIRTY=0
  SCM_STATE=''
  [[ $SCM == $SCM_GIT ]] && git_prompt_info && return
}

# backwards-compatibility
function git_prompt_info {
  git_prompt_vars
  echo -e "$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
}

# export GIT_PS1_SHOWDIRTYSTATE=true
# Powerline symbols: ⮂ ⮃ ⮀ ⮁ ⭤

function prompt_command() {
  if [ "$USERNAME" = "root" ]; then
      user_color="$Red"
  else
      user_color="$Green"
  fi
  # PS1="${debian_chroot:+($debian_chroot)}$(__256bg 233)$(__256fg 240)\u@\h $(__256bg 39)$(__256fg 233)⮀$(__256fg 0) \w $(scm_prompt_info)⮀${Color_Off} "
  PS1="${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${user_color}\u@\h${Color_Off}:${Blue}\w${Color_Off}$(scm_prompt_info)${Color_Off}\$ "
}

TERM="xterm-256color"
PROMPT_COMMAND=prompt_command

shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
