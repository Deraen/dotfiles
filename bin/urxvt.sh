#!/bin/bash

SIZE=17
if [[ $HOSTNAME == "juho-laptop" ]]; then
    if grep -q i7-2640 /proc/cpuinfo; then
        SIZE=13
    fi
fi

exec urxvt \
    -font "xft:Liberation Mono:pixelsize=$SIZE"
