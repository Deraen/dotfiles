#!/bin/bash

source "/home/$USER/.profile"

systemctl --user import-environment

# Disable touchpad
synclient TouchpadOff=1

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides '@a{sv} {"Gtk/ShellShowsAppMenu": <int32 0>}'

export QT_AUTO_SCREEN_SCALE_FACTOR=0

if [[ $HOST == "juho-desktop" ]]; then
    export __GL_SYNC_TO_VBLANK=1
    export __GL_SYNC_DISPLAY_DEVICE=DP-1
    export __VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=DP-1

    # SDL games on one screen only, head=0 => DP-1. maybe...
    # export SDL_VIDEO_FULLSCREEN_HEAD=0
fi

dunst &
nm-applet &
if [[ $HOST == "juho-laptop" ]]; then
    xset dpms 300 300 300
    xss-lock lock.sh &
elif [[ $HOST == "juho-desktop" ]]; then
    xset dpms 600 600 600
fi
rndbg.sh
picom &

xkblayout.sh
frakkin-xkb -t 1000 xkblayout.sh &

export XDG_CURRENT_DESKTOP=ubuntu:GNOME

exec i3
