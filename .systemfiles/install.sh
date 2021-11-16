#!/bin/bash

. "$HOME/.local/lib/functions.sh"

install() {
    if sudo diff "$1" "$HOME/.systemfiles$1" >/dev/null; then
        echo "$1: Ok"
    else
        sudo diff -u "$1" "$HOME/.systemfiles$1"
        if confirm "$1: replace?"; then
            mkdir -p "$(dirname "$1")"
            sudo cp "$HOME/.systemfiles$1" "$1"
        fi
    fi
}

remove() {
    sudo rm -f "$1"
}

install "/etc/default/keyboard"
remove "/etc/udev/rules.d/11-android.rules"
install "/etc/udev/rules.d/51-android.rules"
install "/etc/udev/rules.d/46-TI_launchpad.rules"
install "/etc/udev/rules.d/47-altera.rules"
install "/etc/udev/rules.d/60-vboxdrv.rules"
install "/etc/udev/rules.d/85-tessel.rules"
install "/etc/udev/rules.d/backlight.rules"
install "/usr/share/xsessions/custom.desktop"
install "/usr/share/xsessions/gnome-i3.desktop"
install "/usr/share/gnome-session/sessions/gnome-i3.session"
install "/usr/share/applications/i3-launch.desktop"
install "/usr/bin/gnome-i3"
install "/usr/bin/gnome-session-i3"

if [[ $(hostname -s) == "juho-desktop" ]]; then
    install "/etc/X11/xorg.conf.d/metamodes.conf"
    install "/etc/udev/rules.d/99-pulseaudio.rules"
fi

if [[ $(hostname -s) =~ juho-laptop ]]; then
    # X220
    if grep -q i7-2640 /proc/cpuinfo; then
        install "/etc/thinkfan.conf"
    fi
    install "/etc/NetworkManager/dispatcher.d/99nfs"
    install "/etc/systemd/logind.conf"
    remove "/etc/udev/hwdb.d/99-trackpoint.hwdb"
    install "/etc/libinput/local-overrides.quirks"
fi

sudo update-alternatives --set google-chrome /usr/bin/google-chrome-stable
sudo update-alternatives --set x-www-browser /usr/bin/google-chrome-stable

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --set vi /usr/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --set vim /usr/bin/nvim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --set editor /usr/bin/nvim
