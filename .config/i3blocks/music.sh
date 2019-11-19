#!/bin/bash

if [[ $BLOCK_BUTTON == "1" ]]; then
    playerctl play-pause > /dev/null
elif [[ $BLOCK_BUTTON == "3" ]]; then
    i3-msg workspace number 11 > /dev/null
elif [[ $BLOCK_BUTTON == "4" ]]; then
    playerctl next > /dev/null
elif [[ $BLOCK_BUTTON == "5" ]]; then
    playerctl prev > /dev/null
fi

if [[ "Playing" == $(playerctl status) ]]; then
  echo -e "$(playerctl metadata artist) – $(playerctl metadata title)"
  echo -e "$(playerctl metadata artist) – $(playerctl metadata title)"
else
  echo
  echo
fi
echo "#ffffff"
