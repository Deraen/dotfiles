#!/bin/bash

. "$HOME/.local/lib/functions.sh"

install() {
    SOURCE=$1
    TARGET=$2
    if [[ -z $TARGET ]]; then
        TARGET=$1
    fi

    if [[ -f "$TARGET" ]] && sudo diff "$TARGET" "$HOME/.systemfiles$SOURCE" >/dev/null; then
        echo "[OK] $TARGET"
    else
        if [[ -f "$TARGET" ]]; then
            sudo diff -u "$TARGET" "$HOME/.systemfiles$SOURCE"
            if confirm "[Change] $TARGET: replace?"; then
                sudo mkdir -p "$(dirname "$TARGET")"
                sudo cp "$HOME/.systemfiles$SOURCE" "$TARGET"
            fi
        else
            echo "[Change] $TARGET missing, copying..."
            sudo mkdir -p "$(dirname "$TARGET")"
            sudo cp "$HOME/.systemfiles$SOURCE" "$TARGET"
        fi
    fi
}

remove() {
    if [[ -f "$1" ]]; then
        echo "[Remove] $1"
        sudo rm -f "$1"
    fi
}

if [[ $SHELL != "/usr/bin/zsh" ]]; then
    sudo usermod -s /bin/zsh juho
fi

sudo cp -vRa /usr/share/pipewire /etc/

install "/etc/apt/preferences.d/mozilla-firefox"

remove "/etc/apt/sources.list.d/phoerious-keepassxc-noble.sources"

install "/etc/apt/sources.list.d/beekeeper-studio-app.sources"
install "/etc/apt/sources.list.d/cloud-sdk.sources"
install "/etc/apt/sources.list.d/darktable.sources"
install "/etc/apt/sources.list.d/docker.sources"
install "/etc/apt/sources.list.d/github-cli.sources"
install "/etc/apt/sources.list.d/google-chrome.sources"
install "/etc/apt/sources.list.d/insync.sources"
install "/etc/apt/sources.list.d/papirus-papirus-noble.sources"
install "/etc/apt/sources.list.d/keepassxc.sources"
install "/etc/apt/sources.list.d/slack.sources"
install "/etc/apt/sources.list.d/steam.sources"
install "/etc/apt/sources.list.d/syncthing.sources"
if [[ $(hostname -s) == "juho-desktop" ]]; then
  install "/etc/apt/sources.list.d/deluge.sources"
fi
# install "/etc/apt/sources.list.d/"

install "/etc/sysctl.d/90-local.conf"
install "/etc/default/keyboard"
install "/etc/pam.d/swaylock"
remove "/etc/udev/rules.d/11-android.rules"
install "/etc/udev/rules.d/51-android.rules"
install "/etc/udev/rules.d/46-TI_launchpad.rules"
install "/etc/udev/rules.d/47-altera.rules"
install "/etc/udev/rules.d/60-vboxdrv.rules"
install "/etc/udev/rules.d/85-tessel.rules"
remove "/etc/udev/rules.d/backlight.rules"
install "/etc/udev/rules.d/90-backlight.rules"
remove "/etc/udev/rules.d/91-pulseaudio.rules"
install "/etc/udev/rules.d/95-controllers.rules"
install "/etc/modprobe.d/thinkpad_acpi.conf"
install "/usr/share/xsessions/custom.desktop"
install "/usr/local/share/wayland-sessions/sway-session.desktop"
install "/etc/apt/apt.conf.d/51unattended-upgrades-firefox"
install "/etc/apparmor.d/local/usr.bin.firefox"

if [[ $(hostname -s) == "juho-desktop" ]]; then
    remove "/etc/X11/xorg.conf.d/metamodes.conf"
fi

if [[ $(hostname -s) =~ juho-laptop ]]; then
    # X220
    if grep -q i7-2640 /proc/cpuinfo; then
        install "/etc/thinkfan.conf"
    fi

    # P1 G3
    if grep -q i9-10885H /proc/cpuinfo; then
        install "/etc/thinkfan-p1.yaml" "/etc/thinkfan.yaml"
        install "/etc/tlp.d/100-nvme.conf"
    fi

    # P14 Gen 4
    if grep -q "Ryzen 7 PRO 7840U" /proc/cpuinfo; then
        install "/etc/thinkfan-p14s.yaml" "/etc/thinkfan.yaml"
    fi

    remove "/etc/NetworkManager/dispatcher.d/99nfs"
    install "/etc/systemd/logind.conf.d/lid-and-suspend.conf"
    install "/etc/systemd/system/thinkfan.service.d/override.conf"
    remove "/etc/udev/hwdb.d/99-trackpoint.hwdb"
    install "/etc/libinput/local-overrides.quirks"
fi

sudo update-alternatives --set google-chrome /usr/bin/google-chrome-stable
sudo update-alternatives --set x-www-browser /usr/bin/google-chrome-stable

sudo ln -fs /home/juho/bin/nvim.appimage /usr/local/bin/nvim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 60
sudo update-alternatives --set vi /usr/local/bin/nvim
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60
sudo update-alternatives --set vim /usr/local/bin/nvim
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 60
sudo update-alternatives --set editor /usr/local/bin/nvim
