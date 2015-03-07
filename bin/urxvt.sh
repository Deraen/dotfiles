#!/bin/bash

if [ $HOSTNAME == "juho-desktop" ]; then
    SIZE=17
else
    SIZE=13
fi

exec urxvt \
    -font "xft:Liberation Mono:pixelsize=$SIZE"
