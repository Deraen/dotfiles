#!/bin/bash

if [[ ! -z $1 ]]; then
    export PRESENTATION_MODE=1
    zsh
    exit
fi

exec urxvt \
    --background "#ffffff" \
    --foreground "#222222" \
    --color0 "#4e4e4e" \
    --color1 "#AE6D6D" \
    --color2 "#517351" \
    --color3 "#8C640B" \
    --color4 "#7092B3" \
    --color5 "#A68787" \
    --color6 "#769999" \
    --color7 "#9C9C9C" \
    --color8 "#626262" \
    --color9 "#BF5478" \
    --color10 "#769976" \
    --color11 "#BF862F" \
    --color12 "#95B7D9" \
    --color13 "#DE9898" \
    --color14 "#78BFBF" \
    --color15 "#ABABAB" \
    --cursorColor "#5C5C5C" \
    --cursorColor2 "#3a3a3a" \
    --colorBD "#333333" \
    # -pixmap "$HOME/Dropbox (Metosin)/Metosin Team Folder/logos/valkoinen_taustakuva.png" \
    -font "xft:Liberation Mono:pixelsize=24" \
    -e $0 -x
