#!/bin/bash

xbacklight $@

perc=$(xbacklight)

notify-send "Brightness" -h int:value:$perc
