#!/bin/sh
# Author: Juho Teperi

BAT=/sys/class/power_supply/BAT0
INTERVAL=30

time_start=`date +%s`
if [ -f /sys/class/power_supply/BAT0/energy_now ]; then
        energy_start=$((`cat /sys/class/power_supply/BAT0/energy_now`/1000))
else
        energy_start=$(((`cat /sys/class/power_supply/BAT0/charge_now`/1000)*(`cat /sys/class/power_supply/BAT0/voltage_now`/1000)/1000))
fi

time_last=$time_start
energy_last=$energy_start

echo "Power consumption:"

while true; do
        sleep $INTERVAL

        if [ -f /sys/class/power_supply/BAT0/power_now ]; then
                power_now=$((`cat /sys/class/power_supply/BAT0/power_now`/1000))
                energy_now=$((`cat /sys/class/power_supply/BAT0/energy_now`/1000))
        else
                voltage_now=$((`cat /sys/class/power_supply/BAT0/voltage_now`/1000))
                current_now=$((`cat /sys/class/power_supply/BAT0/current_now`/1000))
                power_now=$((voltage_now*current_now/1000))
                energy_now=$(((`cat /sys/class/power_supply/BAT0/charge_now`/1000)*voltage_now/1000))
        fi
        time_now=`date +%s`

        power_last=$(((energy_last-energy_now)*3600/(time_now-time_last)))
        power_start=$(((energy_start-energy_now)*3600/(time_now-time_start)))

        echo $power_now $power_last $power_start | awk '{printf "Now: %.3f, since last: %.3f, since start: %.3f\n", $1/1000, $2/1000, $3/1000}'

        energy_last=$energy_now
        time_last=$time_now
done
