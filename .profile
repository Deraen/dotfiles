source "$HOME/.config/terminal/functions.sh"

if [ -n "$BASH_VERSION" ]; then
    addSource "$HOME/.bashrc"
fi

addPath "$HOME/bin"
addPath "$HOME/.local/bin"
addPath "$HOME/.config/bspwm/panel"

export PANEL_FIFO="/tmp/panel-fifo"
