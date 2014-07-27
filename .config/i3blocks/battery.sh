#!/bin/bash
# Pass in the output of `acpi -b`
if [[ $BLOCK_BUTTON == "1" ]]; then
    gtk-launch gnome-power-statistics > /dev/null &
fi

acpi -b | awk '
{
    states["Charging"]=""
    states["Discharging"]=""
    states["Unknown"]=""
    states["Full"]=""

    if ($5 == "charging" || $5 == "discharging") {
        # charging at zero rate - will never fully charge.
        # discharging at zero rate - will never fully discharge.
        dur=""
    } else {
        split($5, a, ":")
        if (a[1] == 0 && a[2] == 0) dur=""
        else dur=int(a[1]) "h " int(a[2]) "m"
    }
    percent=int($4)
    sub(",", "", $3)
    status=$3
    bar=""
    i=0
    for (; i < 10 && i < int(percent / 10); ++i) bar=bar "█"
    for (; i < 10; ++i) bar=bar "░"
}
END { print states[status] " " dur " " bar " " percent "%" }'
