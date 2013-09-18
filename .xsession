#!/bin/sh

nm-applet &
gnome-sound-applet &
dropbox start &
[[ "$HOSTNAME" == "juho-laptop" ]] && xset dpms 600
[[ "$HOSTNAME" == "juho-laptop" ]] && xautolock -time 15 -locker "i3lock -c ff9999; suspend.py" &
xcape -e "Alt_L=Escape"

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

exec i3
