#!/bin/bash

if ! [ -d "$HOME/.dropbox-work" ]; then
    mkdir "$HOME/.dropbox-work" 2> /dev/null
    ln -s "$HOME/.Xauthority" "$HOME/dropbox-work/" 2> /dev/null
fi
HOME="$HOME/.dropbox-work"

/home/$USER/.dropbox-dist/dropboxd
