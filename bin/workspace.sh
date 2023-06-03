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
      i3-msg -q "move container to workspace $name"
      shift
      shift
      ;;
    --go-to)
      name=$(get_name "$2")
      i3-msg -q "workspace \"$name\""
      shift
      shift
      ;;
    --rename)
      current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
      current_number=$(split_number "$current_workspace")
      name=$(echo | rofi -dmenu -p "Rename workspace" -l 0)
      jq -r ".[\"$current_number\"] = \"$name\"" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
      if [[ -z $name ]]; then
        new_name="$current_number"
      else
        new_name="$current_number: $name"
      fi
      i3-msg -q "rename workspace \"$current_workspace\" to \"$new_name\""
      shift
      shift
      ;;
    --setup)
      OFS=$IFS
      IFS=$'\n'
      for name in $(jq -r 'to_entries | map(.key + if .value == "" then "" else ": " end + .value) | .[]' "$CONFIG_FILE"); do
        target_number=$(split_number "$name")
        current_name=$(i3-msg -t 'get_workspaces' | jq -r ".[] | select(.num == $target_number).name")
        i3-msg -q "rename workspace \"$current_name\" to \"$name\""
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
