#!/bin/sh

source /home/$USER/.profile

xmodmap .Xmodmap

dunst &
nm-applet &
dropbox start &
if [[ $HOST == "juho-laptop" ]]; then
    xset dpms 600
    xautolock -time 10 -detectsleep -locker "suspend.sh" &
fi
rndbg.sh
compton &

exec i3
