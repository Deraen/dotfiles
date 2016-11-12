#!/bin/bash
if [[ $BLOCK_BUTTON == "1" ]]; then
    scratchpad.py "gtk-launch Sunrise" "crx_mojepfklcankkmikonjlnidiooanmpbb" > /dev/null &
fi

now=$(date +"%a %d %b %H:%M")
tz=$(date +"%Z")
hel=""
if [[ $tz != "EET" ]] && [[ $tz != "EEST" ]]; then
    hel=" | Hel: $(TZ="Europe/Helsinki" date +"%a %d %H:%M")"
fi

echo $now$hel
echo $now$hel
echo "#f3759a"
