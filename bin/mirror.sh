#!/bin/bash

if [[ $1 == "status" ]]; then
  if pgrep -x "wl-mirror" > /dev/null; then
    echo "Mirroring active"
  else
    echo ""
  fi
  echo ""
  echo ""
  exit 0
fi

if pgrep -x "wl-mirror" > /dev/null; then
  pkill wl-mirror
  pkill -SIGRTMIN+1 waybar
  exit 0
fi


OTHER=$(swaymsg -t get_outputs -r | jq '.[] | select (.name != "eDP-1") | .name' -r)

if [[ -z $OTHER ]]; then
  echo "No second display found"
  exit 1
fi

(
  sleep 0.5
  pkill -SIGRTMIN+1 waybar
) &

wl-present mirror eDP-1 --fullscreen-output "$OTHER"
