#!/bin/bash

# PMM - Package Manager Manager!

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. "$DIR/../.local/modules/pmm/init.sh"

# lunar 23.04
# kinetic 22.10
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

# ppa ubuntuhandbook1 gimp jammy --keyid 4C1CBE14852541CB
# ppa ubuntuhandbook1 apps jammy --keyid 4C1CBE14852541CB
# ppa ubuntuhandbook1 darktable kinetic --keyid 4C1CBE14852541CB
# ppa deraen random bionic --keyid 8EE3F468
# ppa pipewire-debian pipewire-upstream kinetic --keyid 25088A0359807596
# ppa pipewire-debian wireplumber-upstream kinetic --keyid 25088A0359807596
ppa papirus papirus lunar --keyid E58A9D36647CAE7F
# ppa mozillateam ppa lunar --keyid 9BDB3D89CE49EC21
repo dropbox "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu disco main" \
        --keyid FC918B335044912E
repo google-chrome "### THIS FILE IS AUTOMATICALLY CONFIGURED ###\n# You may comment out this entry, but any other modifications may be lost.\ndeb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main\n" \
        --keyid 6494C6D6997C215E
repo steam "deb [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam\ndeb-src [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam" \
        --keyid B05498B7
repo virtualbox "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian jammy non-free contrib" \
        --keyid A2F683C52980AECF
repo docker "deb [arch=amd64] https://download.docker.com/linux/ubuntu lunar stable" \
        --keyid 0EBFCD88
repo keybase "### THIS FILE IS AUTOMATICALLY CONFIGURED \n### You may comment out this entry, but any other modifications may be lost.\ndeb http://prerelease.keybase.io/deb stable main\n\n" \
        --key-url https://keybase.io/docs/server_security/code_signing_key.asc
repo cloud-sdk "deb http://packages.cloud.google.com/apt cloud-sdk-disco main" \
        --keyid B53DC80D13EDEF05
repo slack "### THIS FILE IS AUTOMATICALLY CONFIGURED \n### You may comment out this entry, but any other modifications may be lost.\ndeb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main\n\n" \
        --keyid C6ABDCF64DB9A0B2
repo github-cli "deb https://cli.github.com/packages stable main" \
        --key-url https://cli.github.com/packages/githubcli-archive-keyring.gpg
repo darktable "deb http://download.opensuse.org/repositories/graphics:/darktable/xUbuntu_23.04/ /" \
        --key-url "https://download.opensuse.org/repositories/graphics:darktable/xUbuntu_23.04/Release.key"
# repo winehq "deb https://dl.winehq.org/wine-builds/ubuntu/ kinetic main" \
#         --key-url "https://dl.winehq.org/wine-builds/winehq.key"
repo beekeeper-studio-app "deb https://deb.beekeeperstudio.io stable main" \
        --key-url "https://deb.beekeeperstudio.io/beekeeper.key"
repo tailscale "# Tailscale packages for ubuntu lunar\ndeb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/ubuntu lunar main\n\n"
repo insync "deb http://apt.insync.io/ubuntu lunar non-free contrib" \
        --keyid "ACCAF35C"
repo syncthing "deb https://apt.syncthing.net/ syncthing stable" \
        --key-url "https://syncthing.net/release-key.gpg"

if [[ ! -f /usr/share/keyrings/1password-archive-keyring.gpg ]]; then
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
fi

if [[ ! -f /etc/debsig/policies/AC2D62742012EA22/1password.pol ]]; then
        sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
        curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
fi

if [[ ! -f /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg ]]; then
        sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
fi

repo 1password "deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main"

if [[ $(hostname -s) == "juho-desktop" ]]; then
        # Nvidia drivers
        # ppa graphics-drivers ppa kinetic --keyid FCAE110B1118213C
        # ppa lutris-team lutris lunar --keyid 37B90EDD4E3EFAE4
        ppa deluge-team stable kinetic --keyid C5E6A5ED249AD24C
fi

if [[ $(hostname -s) =~ juho-laptop ]]; then
        ppa linrunner tlp lunar --keyid 2B3F92F902D65EFF
        # ppa oibaf graphics-drivers lunar --keyid 957D2708A03A4626

fi

updateRepos

# BASE
install ubuntu-desktop
install ubuntu-minimal
install ubuntu-standard
install ubuntu-restricted-addons
install ubuntu-artwork
install lsb-base
install linux-generic
install build-essential
install libnss-myhostname # Why doesn't systemd-services require this...?
# install linux-signed
install shim-signed
install grub-efi-amd64-signed
install nfs-common
install lvm2
install cryptsetup

# Language stuff
install "language-pack-gnome-en"
install "language-pack-gnome-fi"
install "libreoffice-voikko"
install "libreoffice-l10n-fi"
install "hyphen-fi"
install "hyphen-en-us"
install "libreoffice-l10n-en-gb"
install "firefox-locale-en"

# Devices?
# install usb-modeswitch # for 3G usb modems
install piper # logitech gaming mouse configration

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
install p7zip
install powertop
install silversearcher-ag # Fast file searches
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
install ufw
install libimage-exiftool-perl
install apparmor-utils
install flatpak
install gnome-software-plugin-flatpak

# Editor
install python3-msgpack

# Neovim
install luarocks
install libmsgpack-dev
install xclip

# Java
install openjdk-8-jdk
install openjdk-8-dbg
install openjdk-11-jdk # LTS
install openjdk-17-jdk # LTS
# 21 is the next LTS
install maven
install ant

# Node
install nodejs

# Embedded
# install gcc-msp430 # TI Launchpad
# install mspdebug
install arduino

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
install golang-1.19
install adb
install diffpdf
install pdfarranger
install gdal-bin
install cmatrix
install xmlstarlet
install wireshark
install clinfo
install translate-toolkit

install pipewire
install pipewire-jack
install libspa-0.2-bluetooth
install libspa-0.2-jack
install libpipewire-0.3-common
install wireplumber

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

# swaylock
install libpam0g-dev

install libfontconfig1-dev
install libxcb-render0-dev
install libxcb-shape0-dev
install libxcb-xfixes0-dev
install libxkbcommon-dev

# SwayNotificationCenter
install libgtk-3-dev
install valac
install libhandy-1-dev
install libgtk-layer-shell-dev
install libgee-0.8-dev

# Sway cgroups script
install python3-dbus-next
install python3-i3ipc
install python3-tenacity
install python3-psutil

# Docker
install docker-ce
install docker-compose-plugin
# install sops

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
# install sway
install swaybg
install waybar
install swaylock
install swayidle
install wf-recorder
install wdisplays
install grim
install slurp
install xsettingsd
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

install xdg-desktop-portal-wlr

# GPG stuff
install gnupg
install scdaemon
install keybase
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
install gimp-gmic
install darktable
install google-chrome-stable
install google-chrome-beta
# install meld
install gparted
install inkscape
install keepassxc # Password manager
# install pass
install stress
# install pitivi # Video editor
install xsane
install qgit
install simplescreenrecorder
install mpv
install smplayer
install playerctl
install steam-launcher
install deluge
install virtualbox-7.0
install typecatcher # Install Google webfonts
install cheese # Webcam
install yad # Zenity alternative with proper color picker
install wine-development
install mesa-utils
install nemo
install flameshot
install usb-creator-gtk
install xdotool
install slack-desktop

install network-manager-openconnect-gnome # Cisco VPN
install openvpn
install stoken
install tailscale

install iriunwebcam "2.7" https://iriun.gitlab.io/iriunwebcam-2.7.deb
install v4l2loopback-dkms

install obsidian "1.1.16" https://github.com/obsidianmd/obsidian-releases/releases/download/v1.1.16/obsidian_1.1.16_amd64.deb

# consider greetd and tuigreet for login manager

if [[ $(hostname -s) == "juho-desktop" ]]; then
        install picard # MusicBrainz audio tagger
        # install luminance-hdr # HDR images
        # install hugin # Panorama stitcher
        install jack-rack
        install qjackctl
        install guitarix
        install youtube-dl
        install audacity
        install siril
        install radeontop
        # install mullvad-vpn
        install lutris 0.5.13 "https://github.com/lutris/lutris/releases/download/v0.5.13/lutris_0.5.13_all.deb"
fi

# Laptop specific
if [[ $(hostname -s) =~ "juho-laptop" ]]; then
        # install prey 1.5.1 https://s3.amazonaws.com/prey-releases/node-client/1.5.1/prey_1.5.1_amd64.deb
        # X220
        if grep -q i7-2640 /proc/cpuinfo; then
                install thinkfan
        fi
        if grep -q i9-10885H /proc/cpuinfo; then
                install thinkfan
        fi
        install tlp
        install acpid
        install libgl1:i386
        install libgl1-mesa-dri:i386
        install clamdscan
        install clamtk-gnome
        install beekeeper-studio
        install google-cloud-sdk
        install awscli
fi

markauto
autoremove

# flatpak install flathub org.pipewire.Helvum
snap install spotify
snap install firefox
