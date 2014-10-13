#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    gtk-launch Sunrise > /dev/null &
fi

date +"%a %d %b %H:%M"
