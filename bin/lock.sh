#!/bin/bash

if [[ $1 == "--start" ]]; then
    if [[ $(hostname -s) != "juho-desktop" ]]; then
        swayidle -w timeout 300 'lock.sh -f' before-sleep 'lock.sh -f'
    fi
elif [[ -n $SWAYSOCK ]]; then
    swaylock -c "#1b1b1b" "$@"
else
    i3lock -c "#1b1b1b"
fi
