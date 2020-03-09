#!/bin/bash

# PMM - Package Manager Manager!

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. "$DIR/../.local/modules/pmm/init.sh"

ppa nilarimogard webupd8 eoan --keyid 531EE72F4C9D234C
ppa otto-kesselgulasch gimp eoan --keyid 3BDAAC08614C4B38
ppa rvm smplayer eoan --keyid A7E13D78E4A4F4F4
ppa mc3man mpv-tests eoan --keyid 90BD7EACED8E640A
ppa ansible ansible eoan --keyid 93C4A3FD7BB9C367
ppa neovim-ppa unstable disco --keyid 55F96FCF8231B6DD
ppa yubico stable eoan --keyid 43D5C49532CBA1A9
ppa git-core ppa eoan --keyid A1715D88E1DF1F24
ppa phoerious keepassxc eoan --keyid 61922AB60068FCD6
ppa deraen random bionic --keyid 8EE3F468
ppa s.noack ppa bionic --keyid E1285F2F
# repo getdeb "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" \
#         --key-url http://archive.getdeb.net/getdeb-archive.key
repo dropbox "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu disco main" \
        --keyid FC918B335044912E
repo google-chrome "### THIS FILE IS AUTOMATICALLY CONFIGURED ###\n# You may comment out this entry, but any other modifications may be lost.\ndeb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main\n" \
        --keyid 6494C6D6997C215E
repo heroku "deb http://toolbelt.heroku.com/ubuntu ./" \
        --keyid C927EBE00F1B0520
repo i3 "deb http://debian.sur5r.net/i3/ eoan universe" \
        --keyring sur5r-keyring \
        --keyid 941C42E6
repo steam "deb [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam\ndeb-src [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam" \
        --keyid B05498B7
repo virtualbox "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian eoan non-free contrib" \
        --keyid A2F683C52980AECF
repo docker "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable" \
        --keyid 0EBFCD88
repo keybase "### THIS FILE IS AUTOMATICALLY CONFIGURED \n### You may comment out this entry, but any other modifications may be lost.\ndeb http://prerelease.keybase.io/deb stable main\n\n" \
        --key-url https://keybase.io/docs/server_security/code_signing_key.asc
# repo tarsnap "deb-src http://pkg.tarsnap.com/deb-src/ ./" \
#         --key-url https://pkg.tarsnap.com/tarsnap-deb-packaging-key.asc
repo cloud-sdk "deb http://packages.cloud.google.com/apt cloud-sdk-disco main" \
        --key-url "https://packages.cloud.google.com/apt/doc/apt-key.gpg"
repo mopidy "deb http://apt.mopidy.com/ buster main contrib non-free\ndeb-src http://apt.mopidy.com/ buster main contrib non-free" \
        --key-url https://apt.mopidy.com/mopidy.gpg

if [[ $(hostname -s) == "juho-desktop" ]]; then
        ppa graphics-drivers ppa eoan
        ppa lutris-team lutris eoan \
                --keyid 37B90EDD4E3EFAE4
fi

if [[ $(hostname -s) == "juho-laptop" ]]; then
        ppa linrunner tlp eoan --keyid 2B3F92F902D65EFF
        ppa oibaf graphics-drivers eoan --keyid 957D2708A03A4626
        repo teams "### THIS FILE IS AUTOMATICALLY CONFIGURED ###\n# You may comment out this entry, but any other modifications may be lost.\ndeb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main"

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
install linux-signed-generic
install shim-signed
install grub-efi-amd64-signed
install nfs-common

# Language stuff
install "language-pack-gnome-en"
install "language-pack-gnome-fi"
install "libreoffice-voikko"
install "libreoffice-l10n-fi"
install "openoffice.org-hyphenation"
install "hyphen-en-us"
install "libreoffice-l10n-en-gb"
install "firefox-locale-en"

# Devices?
install usb-modeswitch # for 3G usb modems

# Tools
install curl
install acpi # View ACPI info, e.g. CPU temp (on laptop)
install apache2-utils # htpasswd
install atop # IO top
install htop
install iotop
install jq # JSON processor
install launchpad-getkeys
install ffmpeg
install mosh
install openssh-client
install p7zip
install powertop
install ppa-purge
install silversearcher-ag # Fast file searches
install sshfs
install tmispell-voikko
install tmux
install tree
install zsh
install dos2unix
install rename
install exuberant-ctags
install inotify-tools
install nvme-cli
# Edit ini files (e.g. Trolltech.conf) from CLI
install crudini
install john
install optipng
install webp
install jpegoptim
install libinput-tools
install tarsnap
# apt-get build-dep tarsnap
# apt-get source --compile tarsnap
# dpkg -i ...
install sysfsutils
install command-not-found-data

# Editor
install neovim
install python3-msgpack
install python3-neovim

# Neovim
install luarocks
install libmsgpack-dev
install xclip

# Java
install openjdk-8-jdk
install openjdk-11-jdk
install maven
install ant

# Node
install nodejs
install yarn

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
install pep8
install pylint
install python-pip
install python3-pip
install python3-venv
install python3.8
install python3.8-venv

# Version control
install git
install gitg
install git-flow
install qgit

# Dev tools
install heroku-toolbelt
install devscripts
install ubuntu-dev-tools
install mongodb-org-tools
install sqlite3
# install httpie
install ansible
install ansible-lint
install vagrant 1:2.1.2 https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.deb
install rlwrap
install cloc
install shellcheck
install golang-go
install golang-doc
install golang-src
install golang-1.13
install android-tools-adb
install diffpdf
install gdal-bin
install cmatrix
install sl
install sassc
install xmlstarlet
install wireshark
install phantomjs

# Dev dependencies
install autoconf
install automake
install libboost-all-dev
install libpulse-dev # Ponymix
install libfreetype6-dev
install virtualenv
# frakking-xkb
install libxi-dev
# i3-utils
install libjson-glib-dev
# picom
install meson
install libxext-dev
install libxcb1-dev
install libxcb-damage0-dev
install libxcb-xfixes0-dev
install libxcb-shape0-dev
install libxcb-render-util0-dev
install libxcb-render0-dev
install libxcb-randr0-dev
install libxcb-composite0-dev
install libxcb-image0-dev
install libxcb-present-dev
install libxcb-xinerama0-dev
install libpixman-1-dev
install libdbus-1-dev
install libconfig-dev
install libxdg-basedir-dev
install libgl1-mesa-dev
install libpcre2-dev
install libevdev-dev
install uthash-dev
install libev-dev

install libfontconfig1-dev
install libxcb-render0-dev
install libxcb-shape0-dev
install libxcb-xfixes0-dev
# srandrd
install libxrandr-dev
install libxinerama-dev

# Docker
install docker-ce
install google-cloud-sdk

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
install sur5r-keyring
install i3 # Tiling WM
install i3lock
install i3blocks
install dunst # Notifications
install xss-lock
install rofi # Runner menu
install sway
install compton # Compositing, xcompmgr fork
install gnome-control-center # Includes gnome-sound-applet
install suckless-tools
install "rxvt-unicode-256color"
install faenza-icon-theme
# install polybar
install qt5-style-plugins
install qt5-gtk-platformtheme
install alacritty 0.4.1 https://github.com/alacritty/alacritty/releases/download/v0.4.1/Alacritty-v0.4.1-ubuntu_18_04_amd64.deb

# GPG stuff
install gnupg2
install scdaemon
install keybase
install libu2f-host0
install yubikey-personalization
install yubikey-personalization-gui
install pinentry-gtk2
install pcscd

# GUI software
install blender
install calibre # Ebook library / reader
install d-feet # Browse DBus
install synaptic
install dconf-editor # Edit Dconf settings (mostly Gnome stuff)
install dropbox
install feh
install flashplugin-installer
install ghex # Hex editor
install gimp
# install gimp-plugin-registry
install google-chrome-stable
install google-chrome-beta
install meld
install gparted
install inkscape
install keepassxc # Password manager
install pass
install mumble
install pgadmin3 # PostgreSQL admin
install pgtop
install stress
install libpq-dev
install pitivi # Video editor
install xsane
install qgit
install simplescreenrecorder
install mpv
install smplayer
install playerctl
install steam-launcher
install deluge
install virtualbox-6.1
install typecatcher # Install Google webfonts
install cheese # Webcam
install yad # Zenity alternative with proper color picker
install wine-development
install mesa-utils
install nemo
install flameshot
install usb-creator-gtk
install wmctrl
install xdotool

install mopidy
install mopidy-spotify
install mopidy-beets
install cantata # MPD client
install sonata

install network-manager-openconnect-gnome # Cisco VPN
install ifupdown
install openvpn
install stoken

if [[ $(hostname -s) == "juho-desktop" ]]; then
        install "nvidia-driver-440"
        install nvidia-settings
        install fail2ban
        # HP Touchpad
        # install palm-novacom 1.0.64 ~/Dropbox/Packages/palm-novacom_1.0.64_amd64.deb
        install picard # MusicBrainz audio tagger
        install puddletag # MP3 tagger
        install mp3splt
        install mp3splt-gtk
        # install luminance-hdr # HDR images
        install vdpau-va-driver # Use vdpau from VA api? For VLC?
        install hugin # Panorama stitcher
        install jack-rack # JACK LADSPA effects
        install qjackctl
        install guitarix # Guitar AMP
        install vnstat # Network usage
        install rrdtool # Stats
        install youtube-dl
        install audacity
        install lutris
        install autokey-gtk
fi

# Laptop specific
if [[ $(hostname -s) == "juho-laptop" ]]; then
        install lvm2
        install cryptsetup
        install xbacklight
        # install prey 1.5.1 https://s3.amazonaws.com/prey-releases/node-client/1.5.1/prey_1.5.1_amd64.deb
        # X220
        if grep -q i7-2640 /proc/cpuinfo; then
                install thinkfan
        fi
        install tlp
        install teams
fi

markauto
autoremove
