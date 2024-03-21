source $HOME/.config/terminal/functions.sh

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

exportIfExists ANDROID_HOME "/opt/android-sdk"
exportIfExists ANDROID_HOME "/home/juho/Android/Sdk"

addPath "$HOME/.local/node_modules/.bin"

addPath "$HOME/.cabal/bin"
addPath "$HOME/.stack/programs/x86_64-linux/ghc-7.8.4/bin"
addPath "$HOME/.stack/programs/x86_64-linux/ghc-7.10.1/bin"
addPath "$HOME/.gem/ruby/2.3.0/bin"
addPath "$HOME/.cargo/bin"
addPath "$HOME/Source/go/bin"
addPath "$HOME/.local/share/nvim/lazy/vim-iced/bin"
addPath /usr/lib/go-1.13/bin/
addPath "$ANDROID_HOME/platform-tools"
addPath "$ANDROID_HOME/tools"
addPath /usr/local/cuda-5.5/bin
# Python Poetry
addPath "$HOME/.poetry/bin"
# addPath "$HOME/.platformio/penv/bin"
addPath "$HOME/.krew/bin"
addPath "$HOME/.volta/bin"
exportIfExists VOLTA_HOME "$HOME/.volta"

addPath "$HOME/bin"
addPath "$HOME/.local/bin"

# Enable viewing gziped text files directly
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colors
test -r "$HOME/.local/modules/dircolors-solarized/dircolors.256dark" && eval "$(dircolors $HOME/.local/modules/dircolors-solarized/dircolors.256dark)"
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias apt-add-key='apt-key adv --keyserver keyserver.ubuntu.com --recv-keys '

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# alias iced='shdotenv iced'

# 4k smartcard requires gpg2
export LEIN_GPG=gpg2
export BOOT_GPG_COMMAND=gpg2

export GOPATH="/home/juho/Source/go"

choose_jdk() {
  PREV=$JAVA_HOME
  JAVA_HOME=$1
  if [[ ! -d $JAVA_HOME ]]; then
    echo "Bad java path $JAVA_HOME"
    return 1
  fi
  export JAVA_HOME
  addPath "$JAVA_HOME/jre/bin"
  addPath "$JAVA_HOME/bin"
  removePath "$PREV/bin"
  removePath "$PREV/jre/bin"
  removePath "$PREV/db/bin"

  java -version
}

_choose_jdk_completions() {
  for i in /usr/lib/jvm/*; do
    COMPREPLY+=("$i")
  done
}

complete -F _choose_jdk_completions choose_jdk
