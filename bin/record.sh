#!/bin/bash

# TODO: How to close record if launched from Rofi??
# Open some kind of floating window (so it doens't move anything)
# so the process can be closed

name=$(xdg-user-dir VIDEOS)/$(date +'Recording_%s.mp4')

# Keep proper colors
# https://trac.ffmpeg.org/wiki/Capture/Desktop#LosslessRecording
# Looks like Slack doesn't like the rgb colors (everything is pink)
# Needs high10 or such h264 profile for 10bit colors
# high10 doesn't support lossless
# -c libx264rgb -p crf=0 -p preset=ultrafast -p color_range=2 -p format=gbrp \
wf-recorder \
  -p pix_fmt=yuv422p10le -p crf=0 -p preset=ultrafast -p profile=high444 \
  -g "$(slurp)" -f "$name"

echo "$name"
