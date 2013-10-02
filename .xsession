#!/bin/sh

source /home/$USER/.profile

nm-applet &
gnome-sound-applet &
dropbox start &
[[ "$HOSTNAME" == "juho-laptop" ]] && xset dpms 600
[[ "$HOSTNAME" == "juho-laptop" ]] && xautolock -time 5 -locker "i3lock -c #111111; suspend.py" &
xcape -e "Alt_L=Escape"
rndbg.sh
compton &

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

exec i3
