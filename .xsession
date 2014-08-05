#!/bin/sh

source /home/$USER/.profile

xmodmap .Xmodmap

dunst &
nm-applet &
dropbox start &
if [[ $HOST == "juho-laptop" ]]; then
    xset dpms 600
    light-locker &
    xautolock -time 10 -detectsleep -locker "lock.sh" &
fi
rndbg.sh
compton &

exec i3
