#!/bin/bash

# Active outpu
geometry=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --select)
      geometry=$(slurp)
      shift
      ;;
    --active-window)
      geometry=$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')
      shift
      ;;
    -s|--save)
      output="$(xdg-user-dir PICTURES)/Screenshots/$(date +'Screenshot_%s.png')"
      shift
      ;;
  esac
done

if [[ -n $output ]]; then
    grim -g "$geometry" "$output"
else
    grim -g "$geometry" - | wl-copy
fi
