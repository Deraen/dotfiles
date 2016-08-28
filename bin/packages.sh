#!/bin/bash

# PMM - Package Manager Manager!

. $HOME/.local/modules/pmm/init.sh

ppa maarten-baert simplescreenrecorder xenial
ppa nilarimogard webupd8 xenial # Launchpad-getkeys? Stuff
ppa otto-kesselgulasch gimp xenial
ppa rvm smplayer xenial # Mplayer UI
ppa mc3man mpv-tests xenial # Mpv, mplayer[|2] fork
ppa wine wine-builds xenial
ppa videolan master-daily xenial
ppa webupd8team java xenial # Oracle java
ppa webupd8team sublime-text-3 xenial
ppa webupd8team atom xenial
ppa ansible ansible xenial
ppa neovim-ppa unstable xenial
ppa fish-shell release-2 xenial
ppa openconnect daily vivid
ppa yubico stable xenial
repo dropbox "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu xenial main"
repo google-chrome "### THIS FILE IS AUTOMATICALLY CONFIGURED ###\n# You may comment out this entry, but any other modifications may be lost.\ndeb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main\n"
repo google-talkplugin "deb http://dl.google.com/linux/talkplugin/deb/ stable main"
repo heroku "deb http://toolbelt.heroku.com/ubuntu ./"
repo i3 "deb http://debian.sur5r.net/i3/ xenial universe"
repo spotify "deb http://repository.spotify.com stable non-free"
repo steam "deb [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam\ndeb-src [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam"
repo virtualbox "deb http://download.virtualbox.org/virtualbox/debian xenial non-free contrib"
repo docker "deb https://get.docker.io/ubuntu docker main"
repo fpco "deb http://download.fpcomplete.com/ubuntu/xenial stable main"
repo nodesource "deb https://deb.nodesource.com/node_4.x xenial main\ndeb-src https://deb.nodesource.com/node_4.x xenial main\n"
repo keybase "### THIS FILE IS AUTOMATICALLY CONFIGURED \n### Modifications may be lost.\n\ndeb http://dist.keybase.io/linux/deb/repo stable main\n"
repo tiliado "deb https://tiliado.eu/nuvolaplayer/repository/deb/ xenial stable"
repo slack "### THIS FILE IS AUTOMATICALLY CONFIGURED \n### You may comment out this entry, but any other modifications may be lost.\ndeb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main\n\n"
repo tarsnap "deb-src http://pkg.tarsnap.com/deb-src/ ./"

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        ppa bitcoin bitcoin xenial
        ppa graphics-drivers ppa xenial
fi

if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        ppa linrunner tlp xenial
fi

clearRepos
# launchpad-getkeys?
# apt-get update?

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
install "thunderbird-locale-en"

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
install fish
install dos2unix
install exuberant-ctags
install inotify-tools
# For dmenu.sh
install attr
# Edit ini files (e.g. Trolltech.conf) from CLI
install crudini
install john
install optipng
install tarsnap
# apt-get build-dep tarsnap
# apt-get source --compile tarsnap
# dpkg -i ...

# R
install r-base

# Editor
install vim-gtk
install neovim
install emacs24
install sublime-text-installer
install atom

# Neovim
install luarocks
install libmsgpack-dev
install xclip

# Java
install "oracle-java8-set-default"
install maven
install ant

# Node
install nodejs

# Haskell
install stack

# Prolog
install gprolog

# Embedded
install gcc-msp430 # TI Launchpad
install mspdebug
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
install mongodb-server
install rabbitmq-server
install sqlite3
install httpie
install robomongo 0.8.5 https://download.robomongo.org/0.8.5/linux/robomongo-0.8.5-x86_64.deb
install ansible
install vagrant 1:1.8.4 https://releases.hashicorp.com/vagrant/1.8.4/vagrant_1.8.4_x86_64.deb
install rlwrap
install cloc

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
install libxcb-ewmh-dev
install libxcb-xinerama0-dev
install libxcb-icccm4-dev
install libxkbcommon-dev
install libxkbcommon-x11-dev
install libxcb-xrm-dev
# wlc, sway
install lininput-dev
install linudev-dev
install doxygen
install libgbm-dev
install libxcb-image0-dev
install libxcb-composite0-dev
install libjson-c-dev

# Docker
install lxc-docker

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
install compton # Compositing, xcompmgr fork
install gnome-control-center # Includes gnome-sound-applet
install suckless-tools
install "rxvt-unicode-256color"
install faenza-icon-theme

# GPG stuff
install gnupg2
install pcscd
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
install feh # Image viewer
install flashplugin-installer
install ghex # Hex editor
install gimp
install gimp-plugin-registry
install google-chrome-stable
install google-chrome-beta
install google-talkplugin
install slack-desktop
# install google-play-music-desktop-player
install meld
install gparted
install inkscape
install keepassx # Password manager
install pass
install mumble
install pgadmin3 # PostgreSQL admin
install postgresql-9.5
install pitivi # Video editor
install xsane
install qgit
install quassel-client-qt4 # Irc
install simplescreenrecorder
install mpv
install smplayer
install spotify-client
install nuvolaplayer3
install nuvolaplayer3-google-play-music
install nuvolaplayer3-spotify
install vlc-plugin-fluidsynth
install steam-launcher
install deluge
install unetbootin # Install Linux/etc images into USB stiff
install virtualbox-5.0
install typecatcher # Install Google webfonts
install cheese # Webcam
install sweethome3d
install sweethome3d-furniture
install sweethome3d-furniture-nonfree
install yad # Zenity alternative with proper color picker
install winehq-devel

install network-manager-openconnect-gnome # Cisco VPN
install openvpn

install spotify-client

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        install "nvidia-367"
        install nvidia-settings
        install playonlinux # Wine frontend for games
        install fail2ban
        # HP Touchpad
        install palm-novacom 1.0.64 ~/Dropbox/Packages/palm-novacom_1.0.64_amd64.deb
        install bitcoin-qt
        install picard # MusicBrainz audio tagger
        install puddletag # MP3 tagger
        install mp3splt
        install mp3splt-gtk
        install luminance-hdr # HDR images
        install transmageddon # Video transcoder
        install vdpau-va-driver # Use vdpau from VA api? For VLC?
        install hugin # Panorama stitcher
        install jack-rack # JACK LADSPA effects
        install guitarix # Guitar AMP
        install vnstat # Network usage
        install rrdtool # Stats
        install youtube-dl
fi

# Laptop specific
if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        install lvm2
        install cryptsetup
        install xbacklight
        # install prey 1.5.1 https://s3.amazonaws.com/prey-releases/node-client/1.5.1/prey_1.5.1_amd64.deb
        install thinkfan
        install i965-va-driver
        install tlp
        install xautolock
fi

markauto
autoremove
