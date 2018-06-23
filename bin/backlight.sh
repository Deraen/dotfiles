#!/bin/bash

op=$1
val=$2

max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
cur=$(cat /sys/class/backlight/intel_backlight/brightness)
perc=$((cur * 100 / max))

case $op in
    +) new=$(( perc + val ));;
    -) new=$(( perc - val ));;
    *) echo "Bad operation"; exit 1;;
esac

if [[ $new -lt 0 ]]; then
    new=0
fi

if [[ $new -gt 100 ]]; then
    new=100
fi

notify-send "Brightness" -h "int:value:$new"

new=$((new * max / 100))

tee /sys/class/backlight/intel_backlight/brightness <<< $new
