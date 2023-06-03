#!/bin/bash

# ponymix notify -N option doesn't seem to work
if [[ "$@" == "toggle" ]]; then
    TEXT=" "
    VOLUME=$(ponymix toggle)
    if ponymix is-muted; then
        TEXT="MUTED"
        VOLUME=0
    fi
else
    ponymix unmute
    VOLUME=$(ponymix $@)
fi

if [[ $VOLUME -gt 67 ]]; then
    icon=notification-audio-volume-high
elif [[ $VOLUME -gt 33 ]]; then
    icon=notification-audio-volume-medium
elif [[ $VOLUME -eq 0 ]]; then
    icon=notification-audio-volume-muted
else
    icon=notification-audio-volume-low
fi

notify-send "${VOLUME}% " \
    -h "int:value:$VOLUME" \
    -i "$icon" \
    -h string:x-canonical-private-synchronous:volume \
    -h string:synchronous:volume-change \
    -c volume -t 1000

# Notify i3blocks to update volume block
if [[ -n $SWAYSOCK ]]; then
    echo
else
    pkill -RTMIN+1 i3blocks
fi
