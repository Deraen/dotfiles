#!/bin/bash

if [[ $1 == "--start" ]]; then
    if [[ $(hostname -s) == "juho-desktop" ]]; then
        swayidle \
            timeout 1800 'swaymsg "output * dpms off"' \
            resume 'swaymsg "output * dpms on"'
    else
        swayidle -w timeout 300 "${BASH_SOURCE[0]} -f" before-sleep "${BASH_SOURCE[0]} -f"
    fi
elif [[ -n $SWAYSOCK ]]; then
    swaylock -c "#1b1b1b" "$@"
else
    i3lock -c "#1b1b1b"
fi
