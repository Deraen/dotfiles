#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    gtk-launch gnome-network-panel > /dev/null &
fi

WLAN=$(iwgetid -r)

if [[ $WLAN != "" ]]; then
    echo " $WLAN"
else
    echo ""
fi
