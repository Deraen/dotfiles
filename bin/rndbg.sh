#!/bin/sh
feh --bg-fill "$(find /home/$USER/Dropbox/Wallpapers/ -type f | sort -R | tail -1)"
