#!/bin/sh

exec urxvt \
    -bg "#ffffff" \
    -fg "#222222" \
    -pixmap ~/Dropbox/Programmers/logos/valkoinen_taustakuva.png \
    -font "xft:Liberation Mono:pixelsize=24" \
    -e present-sh.sh
