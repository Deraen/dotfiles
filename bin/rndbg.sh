#!/bin/sh
feh --bg-scale $(find /home/$USER/Pictures/Wallpapers -type f | sort -R | tail -1)
