#!/bin/bash

if [[ "$@" == "toggle" ]]; then
    TEXT=" "
    VOLUME=$(ponymix toggle)
    if ponymix is-muted; then
        TEXT="MUTED"
        VOLUME=0
    fi
    notify-send "$TEXT" \
        -h "int:value:$VOLUME" \
        -h string:x-canonical-private-synchronous:volume \
        -c volume -t 1000
else
    ponymix unmute
    VOLUME=$(ponymix $@)
    notify-send " " \
        -h "int:value:$VOLUME" \
        -h string:x-canonical-private-synchronous:volume \
        -c volume -t 1000
fi

# Notify i3blocks to update volume block
if [[ -n $SWAYSOCK ]]; then
    echo
else
    pkill -RTMIN+1 i3blocks
fi
