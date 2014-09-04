#!/bin/bash

parse-desktop-files.py \
    | sort -t "	" \
    > ~/.cache/desktopfiles.txt
