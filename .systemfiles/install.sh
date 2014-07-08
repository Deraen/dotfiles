#!/bin/bash

installLink() {
    sudo ln -is $HOME/.systemfiles$1 $1
}

installLink "/etc/lightdm/lightdm.conf"
installLink "/etc/default/keyboard"
installLink "/usr/share/X11/xkb/symbols/deraen"
# Overwrite list containing all available options... couldn't find any other way...
installLink "/usr/share/X11/xkb/rules/evdev"
