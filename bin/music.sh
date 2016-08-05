#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: $0 [PlayPause|Previous|Next]"
    exit 1
fi

dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$1
