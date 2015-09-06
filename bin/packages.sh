#!/bin/bash

# PMM - Package Manager Manager!

. $HOME/.local/modules/pmm/init.sh

ppa ajf transmission-remote-gtk-unstable trusty
ppa maarten-baert simplescreenrecorder vivid
ppa nilarimogard webupd8 vivid # Launchpad-getkeys? Stuff
ppa otto-kesselgulasch gimp vivid
ppa rvm smplayer vivid # Mplayer UI
ppa mc3man mpv-tests vivid # Mpv, mplayer[|2] fork
ppa ubuntu-wine ppa vivid
ppa videolan master-daily vivid
ppa webupd8team java vivid # Oracle java
ppa webupd8team sublime-text-3 vivid
ppa webupd8team themes utopic
ppa ansible ansible vivid
ppa neovim-ppa unstable vivid
ppa fish-shell release-2 vivid
repo dropbox "deb http://linux.dropbox.com/ubuntu vivid main"
repo getdeb "deb http://archive.getdeb.net/ubuntu precise-getdeb apps games"
repo google-chrome "deb http://dl.google.com/linux/chrome/deb/ stable main"
repo google-talkplugin "deb http://dl.google.com/linux/talkplugin/deb/ stable main"
repo heroku "deb http://toolbelt.heroku.com/ubuntu ./"
repo i3 "deb http://debian.sur5r.net/i3/ vivid universe"
repo opera "deb http://deb.opera.com/opera-beta/ stable non-free"
repo spotify "deb http://repository.spotify.com stable non-free"
repo steam "deb [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam\ndeb-src [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam"
repo virtualbox "deb http://download.virtualbox.org/virtualbox/debian vivid non-free contrib"
repo docker "deb https://get.docker.io/ubuntu docker main"
repo hipchat "deb http://downloads.hipchat.com/linux/apt stable main"
repo owncloud "deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /"
repo bluejeans "deb http://swdl.bluejeans.com/repos/bluejeans/x86_64/release/debs stable main"
repo fpco "deb http://download.fpcomplete.com/ubuntu/vivid stable main"

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        ppa bitcoin bitcoin vivid
        ppa graphics-drivers ppa vivid
fi

if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        ppa linrunner tlp vivid
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
install tarsnap "1.0.34-1" http://juho.tontut.fi/debs/tarsnap_1.0.34-1_amd64.deb # Backups
install tmispell-voikko
install tmux
install tree
install zsh
install fish
install cloc
install dos2unix
install exuberant-ctags
install inotify-tools

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
install npm

# Haskell
install stack

# Prolog
install gprolog

# Scala
install sbt 0.13.7 http://dl.bintray.com/sbt/debian/sbt-0.13.7.deb

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
install python3-pip
install pylint

# Version control
install git
install gitg
install git-flow
install qgit

# Dev tools
install heroku-toolbelt
install leap 0.8.0 # Leapmotion
install devscripts
install ubuntu-dev-tools
install mongodb-server
install rabbitmq-server
install sqlite3
install httpie
install robomongo 0.8.4 http://robomongo.org/files/linux/robomongo-0.8.4-x86_64.deb
install ansible
install vagrant "1:1.7.2" https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb
install rlwrap

# Dev dependencies
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
# xss-lock
install libxcb-screensaver0-dev
install libxcb-util0-dev
# frakking-xkb
install libxi-dev
# i3-utils
install libjson-glib-dev

# Docker
install lxc-docker

# Tessel
install libusb-1.0-0-dev

# Arduino
install picocom

# TEX
install texlive-latex-extra
install texlive-xetex
install texlive-fonts-recommended
install texlive-lang-european
install biber

install gnuplot-nox

# Desktop env
install i3 # Tiling WM
install i3lock
install compton # Compositing, xcompmgr fork
install gnome-control-center # Includes gnome-sound-applet
install suckless-tools
install "rxvt-unicode-256color"
install faenza-icon-theme

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
install google-chrome-unstable
install google-talkplugin
install meld
install gparted
install inkscape
install keepassx # Password manager
install keepass2
install mumble
install pgadmin3 # PostgreSQL admin
install pitivi # Video editor
install qgit
install quassel-client-qt4 # Irc
install simplescreenrecorder
install skype:i386
install mpv
install smplayer
install spotify-client
install steam-launcher
install transmission-remote-gtk
install transmission-cli
install deluge
install unetbootin # Install Linux/etc images into USB stiff
install virtualbox-4.3
install wine1.7
install typecatcher # Install Google webfonts
install cheese # Webcam
install bjnplugin "2.100.41.8-1" https://swdl.bluejeans.com/skinny/bjnplugin_2.100.41.8-1_amd64.deb

install network-manager-openconnect-gnome # Cisco VPN

install spotify-client

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        install "nvidia-346"
        install playonlinux # Wine frontend for games
        install fail2ban
        install palm-novacom # HP Touchpad. Local?
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
        install adobeair 1:2.6.0.19170 # For Defender's Quest: Valley of the Forgotten
        install youtube-dl
        install openra
fi

# Laptop specific
if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        install linux-signed-generic
        install shim-signed
        install grub-efi-amd64-signed
        install lvm2
        install cryptsetup
        install xbacklight
        install prey 1.4.1 https://s3.amazonaws.com/prey-releases/node-client/1.4.1/prey_1.4.1_amd64.deb
        install thinkfan
        install i965-va-driver
        install tlp
        install xautolock
        install hipchat
        install postgresql-9.4
fi

markauto
autoremove
