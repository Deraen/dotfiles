#!/bin/bash

# PMM? Package Manager Manager!
# Author: Juho Teperi <juho.teperi@iki.fi>

# I have no idea how well this works for a new installation

installpath=/home/juho/bin
. $installpath/packages-functions.sh
. $installpath/packages-repos.sh

ppa ajf transmission-remote-gtk-unstable trusty
ppa chilicuil sucklesstools trusty # Latest dmenu
ppa chris-lea node.js trusty
ppa ehoover compholio trusty # Wine - for pipelight
ppa light-locker release trusty
ppa maarten-baert simplescreenrecorder trusty
ppa mqchael pipelight trusty
# ppa n-muench calibre trusty
ppa natecarlson maven3 precise
ppa nilarimogard webupd8 trusty # Launchpad-getkeys? Stuff
ppa otto-kesselgulasch gimp trusty
ppa rvm smplayer trusty # Mplayer UI
ppa mc3man mpv-tests trusty # Mpv, mplayer[|2] fork
ppa tiheum equinox raring # Faenza-icon-theme
ppa ubuntu-wine ppa trusty
ppa videolan master-daily trusty
ppa webupd8team java trusty # Oracle java
ppa webupd8team sublime-text-3 trusty
repo dropbox "deb http://linux.dropbox.com/ubuntu trusty main"
repo getdeb "deb http://archive.getdeb.net/ubuntu precise-getdeb apps games"
repo google-chrome "deb http://dl.google.com/linux/chrome/deb/ stable main"
repo google-talkplugin "deb http://dl.google.com/linux/talkplugin/deb/ stable main"
repo heroku "deb http://toolbelt.heroku.com/ubuntu ./"
repo i3 "deb http://debian.sur5r.net/i3/ trusty universe"
repo mongodb "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
repo opera "deb http://deb.opera.com/opera-beta/ stable non-free"
repo playonlinux "deb http://deb.playonlinux.com/ precise main"
repo spotify "deb http://repository.spotify.com stable non-free"
repo steam "deb [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam\ndeb-src [arch=amd64,i386] http://repo.steampowered.com/steam/ precise steam"
repo virtualbox "deb http://download.virtualbox.org/virtualbox/debian trusty non-free contrib"
repo docker "deb https://get.docker.io/ubuntu docker main"

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        ppa bitcoin bitcoin raring
        repo google-musicmanager "deb http://dl.google.com/linux/musicmanager/deb/ stable main"
fi

if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        ppa linrunner tlp trusty
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
install language-pack-gnome-en
install language-pack-gnome-fi
install libreoffice-voikko
install libreoffice-l10n-fi
install openoffice.org-hyphenation
install hyphen-en-us
install libreoffice-l10n-en-gb

# Devices?
install usb-modeswitch # for 3G usb modems

# Tools
install acpi # View ACPI info, e.g. CPU temp (on laptop)
install apache2-utils # htpasswd
install atop # IO top
install htop
install iotop
install jq # JSON processor
install launchpad-getkeys
install libav-tools
install mediatomb # UPnP Mediaserver - share videos to TVs / tablet
install mosh
install openssh-client
install p7zip
install powertop
install ppa-purge
install silversearcher-ag # Fast file searches
install sshfs
install tarsnap 1.0.34-1 http://juho.tontut.fi/debs/tarsnap_1.0.34-1_amd64.deb # Backups
install tmispell-voikko
install tmux
install tree
install zsh
install cloc
install dos2unix

# Editor
install vim-gtk
install emacs24
install sublime-text-installer

# Java
install "oracle-java7-set-default"
install maven3
install ant
install jsvc

# Node
install nodejs

# Haskell
install ghc
install cabal-install

# Prolog
install gprolog

# Scala
install sbt 0.13.1-0.1-build-001 http://repo.scala-sbt.org/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.13.1/sbt.deb

# Embedded
install gcc-msp430 # TI Launchpad
install mspdebug
install arduino

# C++
install libllvm3.4
install libclang-3.4-dev
install qtcreator
install valgrind

# Python
install pep8
install python3-pip

# Version control
install git
install gitg
install git-flow
install mercurial

# Dev tools
install heroku-toolbelt
install mono-runtime # This might be useful for running .NET programs (even those targeted at Windows)
install mono-gmcs
install leap 0.8.0 # Leapmotion
install devscripts
install ubuntu-dev-tools
install mongodb-org
install httpie
install robomongo 0.8.4 http://robomongo.org/files/linux/robomongo-0.8.4-x86_64.deb

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

# Docker
install lxc-docker

# Tessel
install libusb-1.0-0-dev

# TEX
install texlive-latex-extra
install texlive-xetex
install texlive-fonts-recommended
install texlive-lang-european
install biber

# Desktop env
install i3 # Tiling WM
install compton # Compositing, xcompmgr fork
install conky-all
install faenza-icon-theme # Folder icons etc. are still horrible on Humanity theme
install light-locker # Use Lightdm as lock screen (enables guest login when locked)

# GUI software
install activity-log-manager # Manage what Zeitgeist saves
install gnome-activity-journal # Browse Zeitgeist history
install avahi-discover # Browse Avahi devices on current network (AirPlay, Pulseaudio)
install blender
install calibre # Ebook library / reader
install comix # CBR/CBZ comicbook reader
install d-feet # Browse DBus
install dconf-editor # Edit Dconf settings (mostly Gnome stuff)
install dropbox
install feh # Image viewer
install flashplugin-installer
install ghex # Hex editor
install gimp
install gimp-plugin-registry
install google-chrome-stable
install google-talkplugin
install gparted
install inkscape
install keepassx # Password manager
install mumble
install pgadmin3 # PostgreSQL admin
install pipelight # Silverlight in browser using wine
install pitivi # Video editor
install playonlinux # Wine frontend for games
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
install unetbootin # Install Linux/etc images into USB stiff
install virtualbox-4.3
install wine1.7
install typecatcher # Install Google webfonts

install network-manager-openconnect-gnome # Cisco VPN

install spotify-client

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        install fail2ban
        install google-musicmanager-beta
        install palm-novacom # HP Touchpad. Local?
        install bitcoin-qt
        install picard # MusicBrainz audio tagger
        install puddletag # MP3 tagger
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
        # Nvidia driver build-deps
        install xserver-xorg-dev
        install execstack
        install dh-modaliases
fi

# Laptop specific
if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        install thermald
        install cheese # Webcam
        install prey 0.6.2-ubuntu2 https://s3.amazonaws.com/prey-releases/bash-client/0.6.2/prey_0.6.2-ubuntu2_all.deb
        install thinkfan
        install i965-va-driver
        install libva-intel-vaapi-driver
        install tlp
        install xautolock
        install hamster-applet
fi

markauto

# Uninstall unnecessary
apt-get autoremove
