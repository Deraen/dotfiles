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
      output="$HOME/Pictures/Screenshots/$(date +'Screenshot_%s.png')"
      shift
      ;;
    -w|--wait)
      wait=$2
      shift
      shift
      ;;
    --ask)
      ASK=$(yad --title "Screenshot" --homogeneous --form --separator "|" \
        --field "Take a screenshot":LBL \
        --field "Select area":CHK TRUE \
        --field "Select active window":CHK FALSE \
        --field "Wait":NUM 0 \
        --field "Save to a file":CHK FALSE \
        --field "Folder":CDIR "$HOME/Pictures/Screenshots" \
        --width 300 --borders 20)
      if [[ "$?" != "0" ]]; then
        echo "Cancelled"
        break
      fi

      shift

      if [[ $(echo "$ASK" | cut -d"|" -f2) == "TRUE" ]]; then
        geometry=$(slurp)
      fi
      if [[ $(echo "$ASK" | cut -d"|" -f3) == "TRUE" ]]; then
        geometry=$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')
      fi
      wait=$(echo "$ASK" | cut -d"|" -f4)
      if [[ $(echo "$ASK" | cut -d"|" -f5) == "TRUE" ]]; then
        output="$(echo "$ASK" | cut -d"|" -f6)/$(date +'Screenshot_%s.png')"
      fi
      ;;
  esac
done

if [[ -n $wait ]]; then
  sleep "$wait"
fi

if [[ -n $output ]]; then
    grim -g "$geometry" "$output"

    # TODO:
    # gdbus call --session \
    #   --dest=org.freedesktop.Notifications \
    #   --object-path=/org/freedesktop/Notifications \
    #   --method=org.freedesktop.Notifications.Notify \
    #   "" 0 "" 'Screenshot taken' 'Open screenshot' \
    #   "[\"default\", \"eog $output\"]" '{"urgency": <1>}' 7000
else
    grim -g "$geometry" - | wl-copy
fi
