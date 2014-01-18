#!/bin/bash

# Adapted from https://gist.github.com/ef4/2075048

DAC="alsa_output.usb-Audinst__Inc._Audinst_HUD-mx1-01-HUDmx1.analog-stereo"
MIC="alsa_input.usb-Samson_Technologies_Samson_GoMic-00-GoMic.analog-mono"

if [ $1 == "--fork" ]; then
    # When run from udev, we fork to give pulseaudio a chance to
    # detect the new device
    bash $0 $2 &
elif [ "$UID" == "0" ]; then
    # If we're running as root, we just forked from udev. Now sleep so pulseaudio can run.
    # Longish wait as DAC takes ~2sec to register (as it is connected through two monitor and usb switch...)
    sleep 4

    # Check process table for users running PulseAudio
    for user in `ps axc -o user,command | grep pulseaudio | cut -f1 -d' ' | sort | uniq`;
    do
        # And relaunch ourselves for each of those users.
        su $user -c "bash $0 $@"
    done
else
    # Running as non-root, so adjust our PulseAudio directly
    if [[ $1 == "dac" ]]; then
        TARGET="sink"
        FOO="input"
        DEVICE=$DAC
    elif [[ $1 == "mic" ]]; then
        TARGET="source"
        FOO="output"
        DEVICE=$MIC
    fi

    pacmd set-default-$TARGET $DEVICE # >/dev/null 2>&1

    for stream in $(pacmd list-$TARGET-${FOO}s | awk '$1 == "index:" {print $2}'); do
        pacmd move-$TARGET-$FOO $stream $DEVICE # >/dev/null 2>&1
    done
fi

# /etc/udev/rules.d/99-pulseaudio.rules
#SUBSYSTEM=="sound", SUBSYSTEMS=="usb", ATTRS{idVendor}=="17a0", ATTRS{idProduct}=="0302", ACTION=="add", RUN+="/home/juho/bin/audiodevices.sh --fork mic"
#SUBSYSTEM=="sound", SUBSYSTEMS=="usb", ATTRS{idVendor}=="1582", ATTRS{idProduct}=="7925", ACTION=="add", RUN+="/home/juho/bin/audiodevices.sh --fork dac"
