. /home/juho/.config/terminal/aliases.sh

if [[ -n $SSH_CONNECTION ]]; then
  export TERM='linux'
  export EDITOR='vim'
else
  export TERM='rxvt-unicode-256color'
  # Neovim GUI
  export EDITOR='vim'
fi

export DEBFULLNAME="Juho Teperi"
export DEBEMAIL="juho.teperi@iki.fi"
export PAGER="less"
export MOST_EDITOR="vim"

[ -n "$TMUX" ] && export TERM=screen-256color

export npm_config_prefix="$HOME/.local"

function exportIfExists {
    [[ -d "$2" ]] && export "$1"="$2"
}

exportIfExists ANDROID_HOME "/raid/opt/android-sdk-linux_x86"
exportIfExists ANDROID_HOME "/opt/android-sdk-linux_x86"
exportIfExists ANDROID_HOME "$HOME/.local/android-sdk"

function addPath {
    [[ -d "$1" ]] && [[ :$PATH: != *:"$1":* ]] && export PATH="$1:$PATH"
}

function addSource {
    [[ -s "$1" ]] && source "$1"
}

addPath "$HOME/bin"
addPath "$HOME/.local/bin"
addPath "$HOME/.local/tpm-bin"
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
addPath "$HOME/.rvm/bin"
addPath "/usr/local/heroku/bin"
addPath "/opt/node-webkit-v0.9.2-linux-x64"

# addSource "$HOME/.pythonbrew/etc/bashrc"
addSource "$HOME/.rvm/scripts/rvm"

# Home git repo, don't show untracked files on status
# pushd $HOME > /dev/null
# git config status.showUntrackedFiles no
# popd > /dev/null

# bash <(curl -kL https://raw.github.com/baabelfish/tpm/master/init)
source /home/juho/.tpm.sh
