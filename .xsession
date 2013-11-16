#!/bin/sh

source /home/$USER/.profile

xmodmap .Xmodmap

nm-applet &
gnome-sound-applet &
dropbox start &
[[ "$HOSTNAME" == "juho-laptop" ]] && xset dpms 600
[[ "$HOSTNAME" == "juho-laptop" ]] && xautolock -time 10 -locker "i3lock -c 111111; suspend.py --force" &
xcape -e "Alt_L=Escape"
rndbg.sh
compton &

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

exec i3
