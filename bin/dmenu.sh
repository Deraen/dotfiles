#!/bin/bash

# Author: Juho Teperi
# This, together with parse-desktop-files.py
# displays dmenu filled with entries from desktop files.
# Most used one is shown first.

STYLE="-i -b -nb #3C3B37 -nf #fff -sb #955 -fn Ubuntu-17"
NAME=$( \
  sort ~/.cache/desktopfilesuses.txt \
  | join -t "	" --nocheck-order -a 1 ~/.cache/desktopfiles.txt - \
  | sort -t "	" -k3 -n -r \
  | cut -f1 \
  | rofi -i -p "" -dmenu $STYLE)

[[ "$NAME" == "" ]] && exit 1

DESKTOPFILE=$(grep "$NAME	" ~/.cache/desktopfiles.txt | cut -f2)

[[ ! -e ~/.cache/desktopfilesuses.txt ]] && touch ~/.cache/desktopfilesuses.txt

MATCH=$(grep "$NAME" ~/.cache/desktopfilesuses.txt)
if [[ "$MATCH" == "" ]]; then
  echo "$NAME	1" >> ~/.cache/desktopfilesuses.txt
else
  MATCHES=${MATCH//[a-zA-Z()]/}
  MATCHES=$[$MATCHES + 1]
  sed -i "s/$MATCH/$NAME	$MATCHES/" ~/.cache/desktopfilesuses.txt
fi

gtk-launch "$DESKTOPFILE" || exec $NAME
