#!/bin/bash
IMAGE=$(find "/home/$USER/Dropbox/Wallpapers/" -type f | sort -R | tail -1)
COLOR=$(convert "$IMAGE" -resize 1x1 -crop 100x100+0+0 +repage txt:- | grep -Po "#[[:xdigit:]]{6}")

if [[ -n $SWAYSOCK ]]; then
    swaymsg output "*" background "$IMAGE" fit "$COLOR"
else
    feh --bg-max "$IMAGE" --image-bg "$COLOR"
fi

echo "$IMAGE $COLOR"
