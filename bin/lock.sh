#!/bin/bash

if [[ $1 == "--start" ]]; then
    swayidle -w timeout 300 'lock.sh -f' before-sleep 'lock.sh -f'
elif [[ -n $SWAYSOCK ]]; then
    swaylock -c "#1b1b1b" "$@"
else
    i3lock -c "#1b1b1b"
fi
