#!/bin/bash

# PMM? Package Manager Manager!
# Author: Juho Teperi <juho.teperi@iki.fi>

# I have no idea how well this works for a new installation

installpath=/home/juho/bin
. $installpath/packages-functions.sh
. $installpath/packages-repos.sh

ppa ajf trg saucy
ppa chilicuil sucklesstools saucy # Latest dmenu
ppa chris-lea node.js saucy
ppa ehoover compholio saucy # Wine - for pipelight
ppa light-locker release saucy
ppa maarten-baert simplescreenrecorder saucy
ppa mizuno-as silversearcher-ag saucy
ppa mqchael pipelight saucy
ppa n-muench calibre saucy
ppa natecarlson maven3 precise
ppa nilarimogard webupd8 saucy # Launchpad-getkeys? Stuff
ppa otto-kesselgulasch gimp saucy
ppa richardgv compton saucy
ppa rvm smplayer saucy # Mplayer UI
ppa mc3man mpv-tests saucy # Mpv, mplayer[|2] fork
ppa tiheum equinox raring # Faenza-icon-theme
ppa ubuntu-wine ppa saucy
ppa videolan master-daily saucy
ppa webupd8team java saucy # Oracle java
ppa webupd8team sublime-text-3 saucy
repo atlassian-hipchat "deb http://downloads.hipchat.com/linux/apt stable main"
repo dropbox "deb http://linux.dropbox.com/ubuntu raring main"
repo getdeb "deb http://archive.getdeb.net/ubuntu precise-getdeb apps games" # Transmission-remote-gtk
repo google-chrome "deb http://dl.google.com/linux/chrome/deb/ stable main"
repo google-talkplugin "deb http://dl.google.com/linux/talkplugin/deb/ stable main"
repo heroku "deb http://toolbelt.heroku.com/ubuntu ./"
repo i3 "deb http://debian.sur5r.net/i3/ saucy universe"
repo mongodb "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
repo opera "deb http://deb.opera.com/opera-beta/ stable non-free"
repo playonlinux "deb http://deb.playonlinux.com/ natty main"
repo spotify "deb http://repository.spotify.com stable non-free"
repo steam "deb http://repo.steampowered.com/steam/ precise steam"
repo virtualbox "deb http://download.virtualbox.org/virtualbox/debian saucy non-free contrib"

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        ppa bitcoin bitcoin raring
        repo google-musicmanager "deb http://dl.google.com/linux/musicmanager/deb/ stable main"
fi

if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        ppa linrunner tlp saucy
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

# Editor
install vim-gtk
install emacs24
install sublime-text-installer

# Java
install oracle-java7-set-default
install maven3
install ant
install nailgun # Start JVM quicky - by running some JVM's on background

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
install git-flow
install mercurial

# Dev tools
install heroku-toolbelt
install mono-runtime # This might be useful for running .NET programs (even those targeted at Windows)
install mono-gmcs
install leap 0.8.0 # Leapmotion
install devscripts
install ubuntu-dev-tools
install mongodb-10gen

# Dev dependencies
install libboost-all-dev
install libpulse-dev # Ponymix
install libxft-dev # Dunst
install libpango1.0-dev # Dunst
install libcairo2-dev # Dunst
install libxdg-basedir-dev # Dunst
install libxss-dev # Dunst (libXscrnsaver)
install libxinerama-dev # Dunst
install libnotify-dev # Dunst

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
install hipchat
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
install steam:i386
install transmission-remote-gtk
install unetbootin # Install Linux/etc images into USB stiff
install virtualbox-4.3
install wine1.7
install typecatcher # Install Google webfonts

if [[ "${HOSTNAME}" == "juho-desktop" ]]; then
        install fail2ban
        install google-musicmanager-beta
        install palm-novacom # Touchpad. Local?
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
fi

# Laptop specific
if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        install cheese # Webcam
        install prey 0.6.2-ubuntu2 https://s3.amazonaws.com/prey-releases/bash-client/0.6.2/prey_0.6.2-ubuntu2_all.deb
        install thinkfan
        install i965-va-driver
        install tlp
        install xautolock
fi

markauto

# Uninstall unnecessary
# apt-get autoremove