#!/bin/bash

WM=i3
if [[ ! -z $1 ]]; then
    WM=$1
fi

# shellcheck source=.profile
source "/home/$USER/.profile"

systemctl --user import-environment

xmodmap .Xmodmap

# Disable touchpad
synclient TouchpadOff=1

/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/gnome-settings-daemon/gsd-rfkill &

eval "$(gpg-agent --daemon --sh)" >/dev/null
export GPG_AGENT_INFO

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
compton &

xkblayout.sh
frakkin-xkb -t 1000 xkblayout.sh &

export XDG_CURRENT_DESKTOP=ubuntu:GNOME

exec "$WM" > "$HOME/.logs/wm-log-$(date +'%F-%k-%M-%S')" 2>&1
# sxhkd &
# panel &
# exec bspwm
