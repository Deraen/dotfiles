source "$HOME/.config/terminal/functions.sh"

if [ -n "$BASH_VERSION" ]; then
    addSource "$HOME/.bashrc"
fi

addPath "$HOME/bin"
addPath "$HOME/.local/bin"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
