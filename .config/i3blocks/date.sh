#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    scratchpad.py "gtk-launch Sunrise" "crx_mojepfklcankkmikonjlnidiooanmpbb" > /dev/null &
fi

date +"%a %d %b %H:%M"
