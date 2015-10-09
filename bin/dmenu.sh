#!/bin/bash

# Author: Juho Teperi
# This, together with parse-desktop-files.py
# displays dmenu filled with entries from desktop files.
# Most used one is shown first.

FILES=~/.cache/desktopfiles/

NAME=$( \
  ls-uses $FILES \
  | sort -r \
  | cut -f2 \
  | rofi -no-levenshtein-sort -b -i -p "" -dmenu)

[[ "$NAME" == "" ]] && exit 1

attr -qs uses -V $(($(attr -qg uses $FILES/$NAME 2>/dev/null || echo 0) + 1)) $FILES/$NAME

gtk-launch "$(cat $FILES/$NAME)" || exec $NAME
