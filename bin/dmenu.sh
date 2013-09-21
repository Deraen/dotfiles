#!/bin/bash

NAME=$(sort .cache/desktopfilesuses.txt | join -t "	" --nocheck-order -a 1 .cache/desktopfiles.txt - | sort -t "	" -k3 -n -r | cut -f1 | dmenu -i -b -nb '#3C3B37' -nf '#fff' -sb '#955' -fn 'Ubuntu-17')
COMMAND=$(grep "$NAME" ~/.cache/desktopfiles.txt | cut -f2)

[[ ! -e ~/.cache/desktopfileuses.txt ]] && touch ~/.cache/desktopfilesuses.txt

MATCH=$(grep "$NAME" ~/.cache/desktopfilesuses.txt)
if [[ "$MATCH" == "" ]]; then
  echo "$NAME	1" >> ~/.cache/desktopfilesuses.txt
else
  MATCHES=${MATCH//[a-zA-Z]/}
  MATCHES=$[$MATCHES + 1]
  sed -i "s/$MATCH/$NAME	$MATCHES/" ~/.cache/desktopfilesuses.txt
fi

echo $COMMAND
