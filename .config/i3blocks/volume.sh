#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    exec gnome-control-center sound > /dev/null &
elif [[ $BLOCK_BUTTON == "3" ]]; then
    ponymix toggle > /dev/null
elif [[ $BLOCK_BUTTON == "4" ]]; then
    ponymix -N increase 2 > /dev/null
elif [[ $BLOCK_BUTTON == "5" ]]; then
    ponymix -N decrease 2 > /dev/null
fi

if ponymix is-muted; then
    echo -e "\uf404 mute";
    echo -e "\uf404 mute";
else
    echo -en "\uf404 ";
    ponymix get-volume | tr -d '\n';
    echo "%";
    echo
fi
echo "#ffffff"
