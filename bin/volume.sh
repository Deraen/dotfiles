#!/bin/bash

if [[ "$@" == "toggle" ]]; then
    ponymix toggle
else
    ponymix unmute
    ponymix $@
fi

# Notify i3blocks to update volume block
pkill -RTMIN+1 i3blocks
