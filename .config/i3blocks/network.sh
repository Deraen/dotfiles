#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    unity-control-center network > /dev/null &
fi

WLAN=$(iwgetid -r)

if [[ $WLAN != "" ]]; then
    echo " $WLAN"
else
    echo ""
fi
