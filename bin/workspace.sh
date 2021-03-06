#!/bin/bash

CONFIG_FILE="$HOME/.config/workspaces.json"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "{}" > "$CONFIG_FILE"
fi

function get_name() {
  name=$(jq -r ".[\"$1\"] // \"\"" "$CONFIG_FILE")
  if [[ -z $name ]]; then
    echo "$1"
  else
    echo "$1: $name"
  fi
}

function split_number() {
  echo "$1" | cut -d':' -f1
}

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    --move-to)
      name=$(get_name "$2")
      i3-msg "move container to workspace $name"
      shift
      shift
      ;;
    --go-to)
      name=$(get_name "$2")
      i3-msg "workspace \"$name\""
      shift
      shift
      ;;
    --rename)
      current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
      current_number=$(split_number "$current_workspace")
      if [[ -n $SWAYSOCK ]]; then
        name=$(echo | wofi --exec-search --dmenu -p "Rename workspace" --height 0)
      else
        name=$(echo | rofi -dmenu -p "Rename workspace" -lines 0 -location 0)
      fi
      jq -r ".[\"$current_number\"] = \"$name\"" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
      if [[ -z $name ]]; then
        new_name="$current_number"
      else
        new_name="$current_number: $name"
      fi
      i3-msg "rename workspace \"$current_workspace\" to \"$new_name\""
      shift
      shift
      ;;
    --setup)
      OFS=$IFS
      IFS=$'\n'
      for name in $(jq -r 'to_entries | map(.key + if .value == "" then "" else ": " end + .value) | .[]' "$CONFIG_FILE"); do
        target_number=$(split_number "$name")
        current_name=$(i3-msg -t 'get_workspaces' | jq -r ".[] | select(.num == $target_number).name")
        i3-msg "rename workspace \"$current_name\" to \"$name\""
      done
      IFS=$OFS
      shift
      ;;
    *)
      # TODO: Help
      shift
      ;;
  esac
done
