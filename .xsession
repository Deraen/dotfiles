#!/bin/sh

source /home/$USER/.profile

xmodmap .Xmodmap

dunst &
nm-applet &
gnome-sound-applet &
dropbox start &
[[ "$HOSTNAME" == "juho-laptop" ]] && xset dpms 600
[[ -f /usr/bin/light-locker ]] && light-locker &
[[ "$HOSTNAME" == "juho-laptop" ]] && xautolock -time 10 -detectsleep -locker "lock.sh" &
xcape -e "Alt_L=Escape;Alt_R=Escape"
setxkbmap -option caps:escape
rndbg.sh
compton &

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

exec i3
