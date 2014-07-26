#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    gtk-launch gnome-sound-panel > /dev/null &
elif [[ $BLOCK_BUTTON == "3" ]]; then
    ponymix toggle > /dev/null
fi

if ponymix is-muted; then
    echo -n " mute";
else
    echo -n " ";
    ponymix get-volume | tr -d '\n';
    echo -n "%";
fi
