#!/bin/bash

# PMM - Package Manager Manager!

. "$HOME/.local/modules/pmm/init.sh"

ppa maarten-baert simplescreenrecorder bionic
ppa nilarimogard webupd8 bionic # Launchpad-getkeys? Stuff
ppa otto-kesselgulasch gimp bionic
ppa rvm smplayer bionic # Mplayer UI
ppa mc3man mpv-tests bionic # Mpv, mplayer[|2] fork
ppa webupd8team java bionic # Oracle java
ppa ansible ansible bionic
ppa neovim-ppa stable bionic
# ppa openconnect daily bionic
ppa yubico stable bionic
ppa git-core ppa bionic
# ppa longsleep golang-backports bionic
ppa phoerious keepassxc bionic
ppa deraen random bionic --keyid 8EE3F468
repo getdeb "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" \
        --key-url http://archive.getdeb.net/getdeb-archive.key
repo dropbox "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu xenial main"
repo google-chrome "### THIS FILE IS AUTOMATICALLY CONFIGURED ###\n# You may comment out this entry, but any other modifications may be lost.\ndeb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main\n"
repo google-talkplugin "deb http://dl.google.com/linux/talkplugin/deb/ stable main"
repo heroku "deb http://toolbelt.heroku.com/ubuntu ./"
repo i3 "deb http://debian.sur5r.net/i3/ bionic universe" \
        --keyring sur5r-keyring \
        --keyid 941C42E6
repo steam "deb [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam\ndeb-src [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam" \
        --keyid B05498B7
repo virtualbox "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic non-free contrib"
repo docker "deb https://apt.dockerproject.org/repo ubuntu-zesty main"
repo fpco "deb http://download.fpcomplete.com/ubuntu/xenial stable main" \
        --keyid 575159689BEFB442
repo nodesource "deb https://deb.nodesource.com/node_8.x bionic main\ndeb-src https://deb.nodesource.com/node_8.x bionic main\n"
repo yarn "deb https://dl.yarnpkg.com/debian/ stable main\n" \
        --key-url https://dl.yarnpkg.com/debian/pubkey.gpg
repo keybase "### THIS FILE IS AUTOMATICALLY CONFIGURED \n### You may comment out this entry, but any other modifications may be lost.\ndeb http://prerelease.keybase.io/deb stable main\n\n" \
        --key-url https://keybase.io/docs/server_security/code_signing_key.asc
repo tarsnap "deb-src http://pkg.tarsnap.com/deb-src/ ./" \
        --key-url https://pkg.tarsnap.com/tarsnap-deb-packaging-key.asc
repo mongodb-org-3.6 "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse"

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        ppa graphics-drivers ppa bionic
        ppa team-xbmc ppa bionic
        repo acestream "deb http://repo.acestream.org/ubuntu/ trusty main"
fi

if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        ppa linrunner tlp bionic
        ppa oibaf graphics-drivers bionic
        repo telred "deb https://tel.red/repos/ubuntu bionic non-free"
fi

updateRepos

# BASE
install ubuntu-desktop
install ubuntu-minimal
install ubuntu-standard
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
install libav-tools
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
# For dmenu.sh
install attr
# Edit ini files (e.g. Trolltech.conf) from CLI
install crudini
install john
install optipng
install jpegoptim
install libinput-tools
install tarsnap
# apt-get build-dep tarsnap
# apt-get source --compile tarsnap
# dpkg -i ...
install sysfsutils

# Editor
install vim-gtk
install neovim
install python3-msgpack
install python3-neovim

# Neovim
install luarocks
install libmsgpack-dev
install xclip

# Java
install "oracle-java8-set-default"
install "oracle-java8-unlimited-jce-policy"
install maven
install ant

# Node
install nodejs
install yarn

# Haskell
install stack

# Prolog
install gprolog

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
install python3-pip
install python3-venv

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
install httpie
install ansible
install vagrant 1:2.1.2 https://releases.hashicorp.com/vagrant/2.1.2/vagrant_2.1.2_x86_64.deb
install rlwrap
install cloc
install shellcheck
install golang-go
install golang-doc
install golang-src
install android-tools-adb
install diffpdf
install gdal-bin

# Dev dependencies
install autoconf
install automake
install libboost-all-dev
install libpulse-dev # Ponymix
# Dunst
install libxft-dev
install libpango1.0-dev
install libcairo2-dev
install libxdg-basedir-dev
install libxss-dev # libXscrnsaver
install libxinerama-dev
install libnotify-dev
install libdbus-1-dev
install libxrandr-dev
install libgtk-3-dev
# xss-lock
install libxcb-screensaver0-dev
install libxcb-util0-dev
# frakking-xkb
install libxi-dev
# i3-utils
install libjson-glib-dev
# rofi
install libstartup-notification0-dev
install libxcb-xkb-dev
install libxcb-randr0-dev
install libxcb-ewmh-dev
install libxcb-xinerama0-dev
install libxcb-icccm4-dev
install libxkbcommon-dev
install libxkbcommon-x11-dev
install libxcb-xrm-dev
install bison
install flex
install librsvg2-dev
# install libpng16-dev
# Python-neovim build-deps
install python-all
install python3-all
install cython
install python-trollius


# Docker
install docker-engine

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
install compton # Compositing, xcompmgr fork
install gnome-control-center # Includes gnome-sound-applet
install suckless-tools
install "rxvt-unicode-256color"
install faenza-icon-theme
install polybar

# GPG stuff
install gnupg2
install scdaemon
install keybase
install libu2f-host0
install yubikey-neo-manager
install yubikey-personalization
install yubikey-personalization-gui
install pinentry-gtk2

# GUI software
install blender
install calibre # Ebook library / reader
install comix # CBR/CBZ comicbook reader
install d-feet # Browse DBus
install synaptic
install dconf-editor # Edit Dconf settings (mostly Gnome stuff)
install dropbox
install feh
install flashplugin-installer
install ghex # Hex editor
install gimp
install gimp-plugin-registry
install google-chrome-stable
install google-chrome-beta
install google-talkplugin
install meld
install gparted
install inkscape
install keepassxc # Password manager
install pass
install mumble
install pgadmin3 # PostgreSQL admin
install postgresql-client-10
install stress
install libpq-dev
install pitivi # Video editor
install xsane
install qgit
install simplescreenrecorder
install mpv
install smplayer
install playerctl 0.6.1 https://github.com/acrisci/playerctl/releases/download/v0.6.1/playerctl-0.6.1_amd64.deb
install libavformat54
install steam-launcher
install deluge
install unetbootin # Install Linux/etc images into USB stiff
install virtualbox-5.2
install typecatcher # Install Google webfonts
install cheese # Webcam
install yad # Zenity alternative with proper color picker
install winehq-devel
install mesa-utils

install network-manager-openconnect-gnome # Cisco VPN
install openvpn

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        install "nvidia-387"
        install nvidia-settings
        install "nvidia-cg-toolkit"
        install playonlinux # Wine frontend for games
        install fail2ban
        # HP Touchpad
        install palm-novacom 1.0.64 ~/Dropbox/Packages/palm-novacom_1.0.64_amd64.deb
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
fi

# Laptop specific
if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        install forticlient-sslvpn
        install lvm2
        install cryptsetup
        install xbacklight
        # install prey 1.5.1 https://s3.amazonaws.com/prey-releases/node-client/1.5.1/prey_1.5.1_amd64.deb
        # X220
        if grep -q i7-2640 /proc/cpuinfo; then
                install thinkfan
        fi
        install i965-va-driver
        install tlp
        install xautolock
        install sky
fi

markauto
autoremove
