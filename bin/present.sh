#!/bin/bash

if [[ ! -z $1 ]]; then
    export PRESENTATION_MODE=1
    zsh
    exit
fi

exec urxvt \
    -bg "#ffffff" \
    -fg "#222222" \
    -pixmap "$HOME/Dropbox (Metosin)/Metosin Team Folder/logos/valkoinen_taustakuva.png" \
    -font "xft:Liberation Mono:pixelsize=24" \
    -e $0 -x
