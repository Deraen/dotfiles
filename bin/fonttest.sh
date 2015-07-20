#!/bin/bash

if [[ $1 ]]; then
    echo $1
    zsh
    exit
fi

OFS=$IFS
IFS=$'\n'

fonts=($(cat <<EOF
xft:Liberation Mono:pixelsize=17|-2
xft:Inconsolata:pixelsize=17|0
xft:Anonymous Pro:pixelsize=17|0
xft:Source Code Pro:pixelsize=17|0
xft:Fantasque Sans Mono:pixelsize=17|0
xft:Fira Mono:pixelsize=17|-2
EOF
))

for f in ${fonts[@]}; do
    OFS=$IFS
    IFS=$'|'
    x=($f)
    IFS=$OFS

    echo ${x[1]}
    urxvt -font "${x[0]}" -letterSpace ${x[1]} -e $0 ${x[0]} &
done
