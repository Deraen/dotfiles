#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    unity-control-center network > /dev/null &
fi

WLAN=$(iwgetid -r)

if [[ $WLAN != "" ]]; then
    echo -e "\uf35c $WLAN"
    echo -e "\uf35c $WLAN"
else
    echo -e "\uf368"
    echo -e "\uf368"
fi
echo "#8ecaed"
