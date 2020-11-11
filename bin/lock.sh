#!/bin/bash
if [[ -n $SWAYSOCK ]]; then
    swaylock -c "#1b1b1b" "$@"
else
    i3lock -c "#1b1b1b"
fi
