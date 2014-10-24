#!/bin/bash

. $HOME/.local/lib/functions.sh

install() {
    if sudo diff $1 $HOME/.systemfiles$1 >/dev/null; then
        echo "$1: Ok"
    else
        sudo diff -u $1 $HOME/.systemfiles$1
        if confirm "$1: replace?"; then
            sudo cp $HOME/.systemfiles$1 $1
        fi
    fi
}

install "/etc/slim.conf"
install "/etc/pam.d/common-session"
install "/etc/polkit-1/localauthority/50-local.d/org.freedesktop.NetworkManager.pkla"
install "/etc/default/keyboard"
install "/etc/udev/rules.d/11-android.rules"
install "/etc/udev/rules.d/46-TI_launchpad.rules"
install "/etc/udev/rules.d/60-vboxdrv.rules"
install "/etc/udev/rules.d/85-tessel.rules"
install "/usr/share/X11/xkb/symbols/deraen"
# Overwrite list containing all available options... couldn't find any other way...
install "/usr/share/X11/xkb/rules/evdev"

if [[ $HOSTNAME == "juho-laptop" ]]; then
    install "/etc/thinkfan.conf"
    install "/etc/X11/xorg.conf.d/20-thinkpad.conf"
    install "/etc/NetworkManager/dispatcher.d/99nfs"
fi
