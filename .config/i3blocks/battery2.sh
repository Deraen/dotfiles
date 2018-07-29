#!/bin/bash

[[ ! -d /sys/class/power_supply/BAT0 ]] && exit

if [[ $BLOCK_BUTTON == "1" ]]; then
    exec gnome-power-statistics > /dev/null &
fi

energy_total=0
energy_now=0
s="Unknown"
power_now=0

add_battery() {
    let energy_total+=$(cat /sys/class/power_supply/$1/energy_full)
    let energy_now+=$(cat /sys/class/power_supply/$1/energy_now)

    x=$(cat /sys/class/power_supply/$1/status)
    if [[ "Unknown" != $x ]] && [[ "Full" != $x ]]; then
        s=$x
        let power_now+=$(cat /sys/class/power_supply/$1/power_now)
    fi
}

add_battery "BAT0"
add_battery "BAT1"

percent=$(( ( $energy_now * 100) / $energy_total ))

duration() {
    hours=$(( $1 / 60 ))
    mins=$(( $1 % 60 ))
    if [[ $hours != 0 ]]; then
        echo -n "${hours}h "
    fi
    echo -n "${mins}m"
}

out=""

if [[ "Charging" == $s ]]; then
    out+=" "
fi

if [[ $power_now != 0 ]]; then
    if [[ "Charging" == $s ]]; then
        missing=$(( $energy_total - $energy_now ))
        charge_min=$(( $missing / ( $power_now / 60 ) ))
        out+="$(duration $charge_min)"
    elif [[ "Discharging" == $s ]]; then
        discharge_min=$(( $energy_now / ( $power_now / 60 ) ))
        out+="$(( power_now / 1000000 ))W | "
        out+="$(duration $discharge_min)"
    fi
fi

out="$out "

i=0
while [[ $i -lt $(( $percent / 10 )) ]]; do
    out+="█"
    let i+=1
done
while [[ $i -lt 10 ]]; do
    out+="░"
    let i+=1
done

out="$out ${percent}%"

echo $out
echo $out
echo "#93dc48"
