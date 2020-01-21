#!/bin/bash
mkdir -p "/home/$USER/.cache/lock_wallpapers"

read -r IMAGE COLOR < <(rndbg.sh)

INAME=$(basename "$IMAGE")
PNG=/home/$USER/.cache/lock_wallpapers/$INAME.png

if [[ ! -f "$PNG" ]]; then
    convert "$IMAGE" -resize 3840x2160 -gravity center -background "$COLOR" -extent 3840x2160 "$PNG"
fi

i3lock -c "#1b1b1b" -i "$PNG"
