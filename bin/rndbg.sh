#!/bin/sh
feh --bg-fill $(find /home/$USER/Pictures/Wallpapers/ -type f | sort -R | tail -1)
