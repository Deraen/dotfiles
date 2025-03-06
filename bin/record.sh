#!/bin/bash

# TODO: How to close record if launched from Rofi??
# Open some kind of floating window (so it doens't move anything)
# so the process can be closed

name=$(xdg-user-dir VIDEOS)/$(date +'Recording_%s.mp4')

# Keep proper colors
# https://trac.ffmpeg.org/wiki/Capture/Desktop#LosslessRecording
wf-recorder \
  -c libx264rgb -p crf=0 -p preset=ultrafast \
  -g "$(slurp)" -f "$name"

echo "$name"
