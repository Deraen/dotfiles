#!/bin/bash

if [ $(pgrep -c keepassx) -eq 1 ]; then
    echo "Starting keepassx"
    keepassx &
fi
i3-msg [class="Keepassx"] scratchpad show
