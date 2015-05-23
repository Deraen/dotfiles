#!/bin/bash

map=$HOME/.xkb/keymap/default

xkbcomp -I"$HOME/.xkb" "$map" "${DISPLAY%%.*}"
