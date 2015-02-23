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

install "/etc/default/keyboard"
install "/etc/udev/rules.d/11-android.rules"
install "/etc/udev/rules.d/46-TI_launchpad.rules"
install "/etc/udev/rules.d/47-altera.rules"
install "/etc/udev/rules.d/60-vboxdrv.rules"
install "/etc/udev/rules.d/85-tessel.rules"
install "/usr/share/X11/xkb/symbols/deraen"
# Overwrite list containing all available options... couldn't find any other way...
install "/usr/share/X11/xkb/rules/evdev"
install "/usr/share/xsessions/custom.desktop"

if [[ $HOSTNAME == "juho-desktop" ]]; then
    install "/etc/X11/xorg.conf.d/metamodes.conf"
    install "/etc/udev/rules.d/99-pulseaudio.rules"
fi

if [[ $HOSTNAME == "juho-laptop" ]]; then
    install "/etc/thinkfan.conf"
    install "/etc/NetworkManager/dispatcher.d/99nfs"
    install "/etc/systemd/logind.conf"
fi

sudo update-alternatives --set dmenu /usr/bin/dmenu.xft

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --set vi /usr/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --set vim /usr/bin/nvim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --set editor /usr/bin/nvim
