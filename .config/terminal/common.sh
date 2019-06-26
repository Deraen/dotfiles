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

addPath "$HOME/bin"
addPath "$HOME/.local/bin"
addPath "$HOME/.local/node_modules/.bin"
addPath "$HOME/.cabal/bin"
addPath "$HOME/.stack/programs/x86_64-linux/ghc-7.8.4/bin"
addPath "$HOME/.stack/programs/x86_64-linux/ghc-7.10.1/bin"
addPath "$HOME/.gem/ruby/2.3.0/bin"
addPath "$HOME/.cargo/bin"
addPath "$HOME/Source/go/bin"
addPath /opt/android-sdk/platform-tools
addPath /opt/android-sdk/tools
addPath /usr/local/cuda-5.5/bin
addPath /opt/PebbleSDK-3.0/bin

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

# 4k smartcard requires gpg2
export LEIN_GPG=gpg2
export BOOT_GPG_COMMAND=gpg2

export NVM_DIR="/home/juho/.nvm"

# Init nvm when first called
nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
  nvm "$@"
}

# Use default nvm version when node/npm called the first time
# and no nvm enabled.
init_nvm() {
  unalias npm
  unalias node
  if [[ -z $NVM_BIN ]]; then
    nvm use default
  fi
  "$@"
}

alias npm='init_nvm npm'
alias node='init_nvm node'

export GOPATH="/home/juho/Source/go"

choose_jdk() {
  VERSION=$1
  PREV=$JAVA_HOME
  JAVA_HOME=/usr/lib/jvm/java-${VERSION}-openjdk-amd64
  if [[ ! -d $JAVA_HOME ]]; then
    echo "Bad java path $JAVA_HOME"
    exit 1
  fi
  export JAVA_HOME
  addPath "$JAVA_HOME/jre/bin"
  addPath "$JAVA_HOME/bin"
  removePath "$PREV/bin"
  removePath "$PREV/jre/bin"
  removePath "$PREV/db/bin"
}
