#!/bin/bash

if [[ $1 == "work" ]]; then
    if ! [ -d "$HOME/.dropbox-work" ]; then
        mkdir "$HOME/.dropbox-work" 2> /dev/null
        pkill dropbox
        env HOME="$HOME/.dropbox-work" /usr/bin/dropbox start -i
    fi
    env HOME="$HOME/.dropbox-work" "/home/$USER/.dropbox-work/.dropbox-dist/dropboxd"
else
    "$HOME/.dropbox-dist/dropboxd"
fi
