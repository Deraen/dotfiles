#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    gtk-launch gnome-sound-panel > /dev/null &
elif [[ $BLOCK_BUTTON == "3" ]]; then
    ponymix toggle > /dev/null
elif [[ $BLOCK_BUTTON == "4" ]]; then
    ponymix -N increase 2
elif [[ $BLOCK_BUTTON == "5" ]]; then
    ponymix -N decrease 2
fi

if ponymix is-muted; then
    echo -n " mute";
else
    echo -n " ";
    ponymix get-volume | tr -d '\n';
    echo -n "%";
fi
