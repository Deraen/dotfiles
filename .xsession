#!/bin/sh

xrandr --output DVI-I-3 --rotate left
xrandr --output DVI-I-2 --right-of DVI-I-3

exec i3
