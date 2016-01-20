#!/bin/sh

source /home/$USER/.profile

xmodmap .Xmodmap

/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GPG_AGENT_INFO SSH_AUTH_SOCK

if [[ $HOST == "juho-desktop" ]]; then
    export __GL_SYNC_TO_VBLANK=1
    export __GL_SYNC_DISPLAY_DEVICE=DP-1
    export __VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=DP-1

    # SDL games on one screen only, head=0 => DP-1. maybe...
    # export SDL_VIDEO_FULLSCREEN_HEAD=0
fi

dunst &
nm-applet &
dropbox start &
dropbox-work.sh &
if [[ $HOST == "juho-laptop" ]]; then
    xset dpms 300
    xset s 300
    xss-lock lock.sh &
elif [[ $HOST == "juho-desktop" ]]; then
    # Acer has diffuculties awakening from sleep
    xset -dpms
fi
rndbg.sh
compton &

xkblayout.sh
frakkin-xkb -t 1000 xkblayout.sh &

exec i3
# sxhkd &
# panel &
# exec bspwm
