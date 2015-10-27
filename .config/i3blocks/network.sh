#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    unity-control-center network > /dev/null &
fi

WLAN=$(iwgetid -r)

if [[ $WLAN != "" ]]; then
    echo " $WLAN"
    echo " $WLAN"
else
    echo ""
    echo ""
fi
echo "#8ecaed"
