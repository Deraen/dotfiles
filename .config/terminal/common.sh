source $HOME/.config/terminal/functions.sh
source $HOME/.config/terminal/aliases.sh

# Disable software flow control (Ctrl-s hangs terminal)
stty -ixon

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  # Neovim GUI
  export EDITOR='vim'
fi

export DEBFULLNAME="Juho Teperi"
export DEBEMAIL="juho.teperi@iki.fi"
export PAGER="less"
export MOST_EDITOR="vim"

# History
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
SAVEHIST=10000

exportIfExists ANDROID_HOME "/raid/opt/android-sdk-linux_x86"
exportIfExists ANDROID_HOME "/opt/android-sdk-linux_x86"
exportIfExists ANDROID_HOME "$HOME/.local/android-sdk"

addPath "$HOME/bin"
addPath "$HOME/.local/bin"
addPath "$HOME/.local/node_modules/.bin"
addPath "$HOME/.cabal/bin"
addPath "$HOME/.stack/programs/x86_64-linux/ghc-7.8.4/bin"
addPath "$HOME/.stack/programs/x86_64-linux/ghc-7.10.1/bin"
addPath /raid/opt/android-sdk-linux_x86/platform-tools
addPath /raid/opt/android-sdk-linux_x86/tools
addPath /raid/opt/android-ndk
addPath /opt/android-sdk-linux_x86/platform-tools
addPath /opt/android-sdk-linux_x86/tools
addPath /opt/android-ndk
addPath /usr/local/cuda-5.5/bin
addPath /opt/PebbleSDK-3.0/bin

if [[ $(uname) != "Linux" ]]; then
  addPath $(brew --prefix coreutils)/libexec/gnubin
  addPath $(brew --prefix gnu-sed)/libexec/gnubin
  addPath /usr/local/sbin
  addPath /Users/juho/.stack/programs/x86_64-osx/ghc-7.8.4/bin

  MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Enable viewing gziped text files directly
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colors
test -r $HOME/.local/modules/dircolors-solarized/dircolors.256dark && eval "$(dircolors $HOME/.local/modules/dircolors-solarized/dircolors.256dark)"
alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# 4k smartcard requires gpg2
export LEIN_GPG=gpg2
