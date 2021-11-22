#!/bin/bash

# TODO: How to close record if launched from Rofi??
# Open some kind of floating window (so it doens't move anything)
# so the process can be closed

wf-recorder -g "$(slurp)" -f "$(xdg-user-dir VIDEOS)/$(date +'Recording_%s.mp4')"
