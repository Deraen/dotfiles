#!/bin/bash

# PMM - Package Manager Manager!

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. "$DIR/../.local/modules/pmm/init.sh"

# resolute 26.04
# questing 25.10
# plucky 25.04
# oracular 24.10
# noble 24.04 lts
# jammy 22.04 lts
# focal 20.04 lts
# disco 19.04
# precise 12.04 lts

## check local packages (not from repo):
# apt list --installed | grep installed,local
## check transitional packages:
# dpkg -l | grep transitional
## old configuration:
# dpkg -l | grep ^rc

# NOTE: New deb822 format sources are managed with the systemfiles script
# TODO: Move the rest to that

if [[ ! -s /etc/apt/keyrings/packages.mozilla.org.asc ]]; then
        wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
fi
repo mozilla "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main"

repo dropbox "deb [arch=i386,amd64 signed-by=/etc/apt/keyrings/dropbox.asc] http://linux.dropbox.com/ubuntu noble main\n\n" \
        --keyid FC918B335044912E
if [[ ! -s /usr/share/keyrings/oracle-virtualbox-2016.gpg ]]; then
        curl -sS https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
fi
repo virtualbox "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian oracular contrib"
# repo keybase "### THIS FILE IS AUTOMATICALLY CONFIGURED \n### You may comment out this entry, but any other modifications may be lost.\ndeb http://prerelease.keybase.io/deb stable main\n\n" \
#         --key-url https://keybase.io/docs/server_security/code_signing_key.asc

# -s check to check if file is present and non-empty
if [[ ! -s /usr/share/keyrings/tailscale-archive-keyring.gpg ]]; then
        curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
fi

repo tailscale "# Tailscale packages for ubuntu noble\ndeb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/ubuntu noble main\n\n"

if [[ ! -s /usr/share/keyrings/1password-archive-keyring.gpg ]]; then
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
fi

if [[ ! -s /etc/debsig/policies/AC2D62742012EA22/1password.pol ]]; then
        sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
        curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
fi

if [[ ! -s /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg ]]; then
        sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
fi

repo 1password "deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main"

# if [[ $(hostname -s) == "juho-desktop" ]]; then
        # ppa lutris-team lutris noble --keyid 37B90EDD4E3EFAE4
        # ppa kdenlive kdenlive-stable noble --keyid 2763B0EE7709FE97
# fi

if [[ $(hostname -s) =~ juho-laptop ]]; then
        # ppa oibaf graphics-drivers noble --keyid 957D2708A03A4626

        if [[ ! -s /etc/apt/keyrings/kubernetes-apt-keyring.gpg ]]; then
                curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
        fi
        repo kubernetes "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /"

fi

updateRepos

# BASE
install ubuntu-desktop
install ubuntu-minimal
install ubuntu-standard
install ubuntu-restricted-addons
install ubuntu-artwork
install sysvinit-utils
install linux-generic
install linux-lowlatency
install build-essential
install libnss-myhostname # Why doesn't systemd-services require this...?
# install linux-signed
install shim-signed
install grub-efi-amd64-signed
install nfs-common
install lvm2
install cryptsetup
install lm-sensors

# Language stuff
install "language-pack-gnome-en"
install "language-pack-gnome-fi"
install "libreoffice-voikko"
install "libreoffice-l10n-fi"
install "hyphen-fi"
install "hyphen-en-us"
install "libreoffice-l10n-en-gb"

# Devices?
install piper # logitech gaming mouse configration
install solaar

# Tools
install curl
install acpi # View ACPI info, e.g. CPU temp (on laptop)
# install apache2-utils # htpasswd
install atop # IO top
install htop
install iotop
install jq # JSON processor
install yamllint
install ffmpeg
install openssh-client
install 7zip
install powertop
install silversearcher-ag # Fast file searches
install fd-find
install ripgrep
install tmispell-voikko
install tmux
install tree
install zsh
install direnv
install dos2unix
install rename
install universal-ctags
install inotify-tools
install nvme-cli
install sshfs
install smartmontools
install exfat-fuse
install exfatprogs
install scrub
# Edit ini files (e.g. Trolltech.conf) from CLI
install crudini
install john
install optipng
install webp
install jpegoptim
install libinput-tools
install sysfsutils
install traceroute
install firewalld
install firewall-applet
install firewall-config
install libimage-exiftool-perl
install gifsicle
install mediainfo
install apparmor-utils
install flatpak
install gnome-software-plugin-flatpak
install hwinfo
install libfuse2t64
install lxpolkit
install tlp
install httrack
install moreutils

# Editor
install python3-msgpack

# Neovim
install luarocks
install xclip

# Java
install openjdk-8-jdk
install openjdk-8-dbg
install openjdk-11-jdk # LTS
install openjdk-17-jdk # LTS
install openjdk-21-jdk # LTS
# 25 is the next LTS
install maven
install ant

# Node
install nodejs

# Embedded
# install gcc-msp430 # TI Launchpad
# install mspdebug
install arduino
install esptool

# C++
install clang
install qtcreator
install valgrind
install cmake
install cppcheck

# Python
install pycodestyle
install pylint
install pipenv
install python3
install python3-pip
install python3-venv

# Version control
install git
install gitg
install git-flow
install git-lfs
install git-revise
install qgit

# Dev tools
install devscripts
install ubuntu-dev-tools
install sqlite3
# install httpie
install ansible
install rlwrap
install cloc
install shellcheck
install golang-go
install golang-doc
install golang-src
install adb
install diffpdf
install kdiff3
install meld
install pdfarranger
install dupeguru
install gdal-bin
install gpsbabel
install cmatrix
install xmlstarlet
install wireshark
install clinfo
install translate-toolkit

install pipewire
install pipewire-jack
install libspa-0.2-bluetooth
install libspa-0.2-jack
install libspa-0.2-libcamera
install libpipewire-0.3-common
install wireplumber
install helvum
install easyeffects

# Dev dependencies
install autoconf
install automake
install libboost-all-dev
install libpulse-dev # Ponymix
install libfreetype-dev
install virtualenv
# frakking-xkb
install libxi-dev
# i3-utils
install libjson-glib-dev
# vim-clap
install libssl-dev

# wlroots
install wayland-protocols
install libwayland-dev
install libegl1-mesa-dev
install libgles-dev
install libdrm-dev
install libgbm-dev
install libinput-dev
install libxkbcommon-dev
install libgudev-1.0-dev
install libpixman-1-dev
install libsystemd-dev
install libpng-dev
install libavutil-dev
install libavcodec-dev
install libavformat-dev
install libxcb-composite0-dev
install libxcb-icccm4-dev
install libxcb-image0-dev
install libxcb-render0-dev
install libxcb-xfixes0-dev
install libxkbcommon-dev
install libxcb-xinput-dev
install libx11-xcb-dev
install libxcb-dri3-dev
install libxcb-res0-dev
install libvulkan-dev
install libseat-dev
install glslang-dev
install hwdata

# sway
install libjson-c-dev
install libpango1.0-dev
install libcairo2-dev
install libgdk-pixbuf-2.0-dev
install scdoc
install libxcb-ewmh-dev
install libliftoff-dev
install libdisplay-info-dev
install glslang-tools

# swaylock
install libpam0g-dev

install libfontconfig1-dev
install libxcb-render0-dev
install libxcb-shape0-dev
install libxcb-xfixes0-dev
install libxkbcommon-dev

# hyprpicker
install libhyprutils-dev
install hyprwayland-scanner
install ninja-build

# Sway cgroups script
install python3-dbus-next
install python3-i3ipc
install python3-tenacity
install python3-psutil

# Docker
install docker-ce
install docker-compose-plugin
# install sops
# install confftest 0.49.1 "https://github.com/open-policy-agent/conftest/releases/download/v0.49.1/conftest_0.49.1_linux_amd64.deb"

# Tessel
install libusb-1.0-0-dev

# Arduino
install picocom

install graphviz

# TEX
install texlive-latex-extra
install texlive-bibtex-extra
install texlive-xetex
install texlive-fonts-recommended
install lmodern
install texlive-lang-european
install biber

install gnuplot-nox

# Desktop env
install i3 # Tiling WM
install i3lock
install i3blocks
install xss-lock
install rofi # Runner menu
install sway
install swaybg
install swayimg
install waybar
install swaylock
install swayidle
install sway-notification-center
install kanshi
install wf-recorder
install wdisplays
install grim
install slurp
install xsettingsd
install keyd
install pavucontrol
# install mako-notifier
install qtwayland5
install brightnessctl
install wl-clipboard
install gnome-control-center # Includes gnome-sound-applet
install unity-settings-daemon
install unity-services
install suckless-tools
install papirus-icon-theme
# install polybar
install qt5-style-plugins
install qt5-gtk-platformtheme
install 1password
install policykit-1-gnome
install fonts-roboto
install fonts-font-awesome
install fonts-powerline
install fonts-material-design-icons-iconfont
install gammastep
install alacritty

install xdg-desktop-portal-wlr

# GPG stuff
install gnupg
install scdaemon
# install keybase
install libu2f-host0
install pinentry-gtk2
install pcscd

# GUI software
install blender
install calibre # Ebook library / reader
install d-feet # Browse DBus
install dconf-editor # Edit Dconf settings (mostly Gnome stuff)
install dropbox
install insync
install feh
install ghex # Hex editor
install gimp
install gimp-plugin-registry
# install gimp-gmic
install darktable
install google-chrome-stable
install google-chrome-beta
install firefox
# install meld
install fdisk
install gparted
install inkscape
install python3-scour # svg optimizer used by inkscape
install keepassxc-full # Password manager
install qrencode
install pass
install qtpass
# install pass
install stress
# install pitivi # Video editor
install xsane
install qgit
install gh
install just # task runner
install simplescreenrecorder
install mpv
install smplayer
install playerctl
install steam-launcher
install python3-legacy-cgi # needed for deluge for some reason?
install deluge
install virtualbox-7.1
install cheese # Webcam
install guvcview
install yad # Zenity alternative with proper color picker
install mesa-utils
install nemo
install flameshot
install usb-creator-gtk
install xdotool
install slack-desktop
install synaptic
install audacity

install wine
install winetricks
# TODO: Needs urls? https://github.com/Open-Wine-Components/umu-launcher/releases
install umu-launcher
install python3-umu-launcher
install dxvk
install dxvk-wine64
install lutris

install mesa-va-drivers
install mesa-vdpau-drivers
install vainfo
install vulkan-tools

install network-manager-applet
install network-manager-strongswan
install libstrongswan-extra-plugins
install network-manager-openconnect-gnome # Cisco VPN
install openvpn
install stoken
install tailscale
install wakeonlan

install iriunwebcam
# install iriunwebcam "2.8.5" "https://iriun.gitlab.io/iriunwebcam-2.8.5.deb"
# install v4l2loopback-dkms

OBSIDIAN="1.8.9"
install obsidian "$OBSIDIAN" "https://github.com/obsidianmd/obsidian-releases/releases/download/v$OBSIDIAN/obsidian_${OBSIDIAN}_amd64.deb"

install obs-studio


# consider greetd and tuigreet for login manager

if [[ $(hostname -s) == "juho-desktop" ]]; then
        install picard # MusicBrainz audio tagger
        # install luminance-hdr # HDR images
        # install hugin # Panorama stitcher
        install qjackctl
        install guitarix
        install yt-dlp
        install siril
        install digikam
        install radeontop
        # install mullvad-vpn
        # for davinci
        install mesa-opencl-icd
        # install kdenlive
        install davinci-resolve
fi

# Laptop specific
if [[ $(hostname -s) =~ "juho-laptop" ]]; then
        # install prey 1.5.1 https://s3.amazonaws.com/prey-releases/node-client/1.5.1/prey_1.5.1_amd64.deb
        # X220
        if grep -q i7-2640 /proc/cpuinfo; then
                install thinkfan
        fi
        # P1 g3
        if grep -q i9-10885H /proc/cpuinfo; then
                install thinkfan
        fi
        # P14s g4
        if grep -q "Ryzen 7 PRO 7840U" /proc/cpuinfo; then
                install thinkfan
        fi
        install acpid
        install libgl1:i386
        install libgl1-mesa-dri:i386
        install clamdscan
        install clamtk-gnome
        install beekeeper-studio
        install google-cloud-sdk
        install google-cloud-cli-gke-gcloud-auth-plugin
        install google-cloud-sdk-gke-gcloud-auth-plugin
        install kubectl
        install kubectx

        install cnrdrvcups-ufr2-uk "5.70-1.18" "/home/juho/Downloads/linux-UFRII-drv-v570-m17n/x64/Debian/cnrdrvcups-ufr2-uk_5.70-1.18_amd64.deb"
fi

markauto
autoremove

snap install spotify
snap install aws-cli --classic
