#!/bin/bash

. "$HOME/.local/lib/functions.sh"

install() {
    if [[ -f "$1" ]] && sudo diff "$1" "$HOME/.systemfiles$1" >/dev/null; then
        echo "$1: Ok"
    else
        if [[ -f "$1" ]]; then
            sudo diff -u "$1" "$HOME/.systemfiles$1"
            if confirm "$1: replace?"; then
                sudo mkdir -p "$(dirname "$1")"
                sudo cp "$HOME/.systemfiles$1" "$1"
            fi
        else
            echo "$1 missing, copying..."
            sudo mkdir -p "$(dirname "$1")"
            sudo cp "$HOME/.systemfiles$1" "$1"
        fi
    fi
}

remove() {
    sudo rm -f "$1"
}

install "/etc/default/keyboard"
install "/etc/pam.d/swaylock"
remove "/etc/udev/rules.d/11-android.rules"
install "/etc/udev/rules.d/51-android.rules"
install "/etc/udev/rules.d/46-TI_launchpad.rules"
install "/etc/udev/rules.d/47-altera.rules"
install "/etc/udev/rules.d/60-vboxdrv.rules"
install "/etc/udev/rules.d/85-tessel.rules"
install "/etc/udev/rules.d/backlight.rules"
install "/etc/modprobe.d/thinkpad_acpi.conf"
install "/usr/share/xsessions/custom.desktop"

if [[ $(hostname -s) == "juho-desktop" ]]; then
    install "/etc/X11/xorg.conf.d/metamodes.conf"
    install "/etc/udev/rules.d/99-pulseaudio.rules"
fi

if [[ $(hostname -s) =~ juho-laptop ]]; then
    # X220
    if grep -q i7-2640 /proc/cpuinfo; then
        install "/etc/thinkfan.conf"
    fi

    # P1 G3
    if grep -q i9-10885H /proc/cpuinfo; then
        install "/etc/thinkfan.yaml"
    fi

    install "/etc/NetworkManager/dispatcher.d/99nfs"
    install "/etc/systemd/logind.conf"
    install "/etc/systemd/system/thinkfan.service.d/override.conf"
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
