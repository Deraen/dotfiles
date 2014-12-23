#!/bin/sh

source /home/$USER/.profile

xmodmap .Xmodmap

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GPG_AGENT_INFO SSH_AUTH_SOCK

dunst &
nm-applet &
dropbox start &
if [[ $HOST == "juho-laptop" ]]; then
    xset dpms 300
    xset s 300
    xss-lock lock.sh &
fi
rndbg.sh
compton &

exec i3
