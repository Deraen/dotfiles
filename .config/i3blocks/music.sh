#!/bin/bash

if [[ "Playing" == $(playerctl status) ]]; then
  echo -e "$(playerctl metadata artist) – $(playerctl metadata title)"
  echo -e "$(playerctl metadata artist) – $(playerctl metadata title)"
else
  echo
  echo
fi
echo "#ffffff"
