source /home/juho/.config/terminal/functions.sh
source /home/juho/.config/terminal/aliases.sh

# Disable software flow control (Ctrl-s hangs terminal)
stty -ixon

if [[ -n $SSH_CONNECTION ]]; then
  export TERM='linux'
  export EDITOR='vim'
else
  export TERM='rxvt-unicode-256color'
  # Neovim GUI
  export EDITOR='vim'
fi

[ -n "$TMUX" ] && export TERM=screen-256color

if [ -n "$DESKTOP_SESSION" ];then
  eval $(gnome-keyring-daemon --start --components=ssh)
  export SSH_AUTH_SOCK
fi

export DEBFULLNAME="Juho Teperi"
export DEBEMAIL="juho.teperi@iki.fi"
export PAGER="less"
export MOST_EDITOR="vim"

# History
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
SAVEHIST=10000

export npm_config_prefix="$HOME/.local"

exportIfExists ANDROID_HOME "/raid/opt/android-sdk-linux_x86"
exportIfExists ANDROID_HOME "/opt/android-sdk-linux_x86"
exportIfExists ANDROID_HOME "$HOME/.local/android-sdk"

addPath "$HOME/bin"
addPath "$HOME/.local/bin"
addPath "$HOME/.cabal/bin"
addPath /raid/opt/android-sdk-linux_x86/platform-tools
addPath /raid/opt/android-sdk-linux_x86/tools
addPath /raid/opt/android-ndk
addPath /opt/android-sdk-linux_x86/platform-tools
addPath /opt/android-sdk-linux_x86/tools
addPath /opt/android-ndk
addPath /usr/local/cuda-5.5/bin
addPath "/Applications/Android Studio.app/sdk/platform-tools"
addPath "/Applications/Android Studio.app/sdk/tools"

# addSource "$HOME/.pythonbrew/etc/bashrc"

# Home git repo, don't show untracked files on status
$(cd $HOME ; git config status.showUntrackedFiles no)

# Enables for example viewing gziped text files directly
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colors
test -r $HOME/.local/modules/dircolors-solarized/dircolors.256dark && eval "$(dircolors $HOME/.local/modules/dircolors-solarized/dircolors.256dark)"
alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
