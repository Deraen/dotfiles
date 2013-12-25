#!/bin/bash

# BASE
INSTALL="ubuntu-desktop
ubuntu-minimal
ubuntu-standard
lsb-base
lsb-core
linux-generic
build-essential
language-pack-gnome-en
language-pack-gnome-fi"

# Repos
INSTALL="${INSTALL}
getdeb-repository
playdeb"

# Devices?
INSTALL="${INSTALL}
usb-modeswitch"

# Tools
INSTALL="${INSTALL}
openssh-client
libav-tools
dos2unix
ppa-purge
foremost
launchpad-getkeys
apt-rdepends
acpi
mosh
tree
tmux
zsh
powertop
jq
silversearcher-ag
vim-gtk
emacs24
sshfs
atop
htop
apache2-utils
tarsnap
gcc-msp430
mspdebug
p7zip
mediatomb
ccze
tmispell-voikko"

# Programming languages
INSTALL="${INSTALL}
oracle-java7-set-default
nodejs
ghc
gprolog"

# DEV
INSTALL="${INSTALL}
libllvm3.4
libclang-3.4-dev
arduino
pep8
python3-pip
heroku-toolbelt
git
mongodb-10gen
maven3
ant
mercurial
valgrind
cabal-install
git-flow
qtcreator
mono-runtime
mono-gmcs
sbt
nailgun
tcl
leap
devscripts
ubuntu-dev-tools
libboost-all-dev"

# TEX
INSTALL="${INSTALL}
texlive
texlive-latex-extra
texlive-xetex
texlive-fonts-recommended
texlive-lang-european
biber"

# Desktop env
INSTALL="${INSTALL}
i3
compton
conky-all
xautolock
faenza-icon-theme
light-locker"

# GUI software
INSTALL="${INSTALL}
prey
virtualbox-4.3
google-chrome-stable
google-talkplugin
sublime-text-installer
comix
qgit
dropbox
steam:i386
calibre
feh
mumble
transmission-remote-gtk
pipelight
blender
cheese
hipchat
skype:i386
inkscape
gimp
gimp-plugin-registry
keepassx
pitivi
playonlinux
pgadmin3
flashplugin-installer
spotify-client
smplayer2
simplescreenrecorder
quassel-client-qt4
gnome-activity-journal
ghex"

# GUI "tools"
INSTALL="${INSTALL}
activity-log-manager
unetbootin
avahi-discover
d-feet
dconf-editor
gparted
libreoffice-voikko
libreoffice-l10n-fi
openoffice.org-hyphenation
hyphen-en-us
libreoffice-l10n-en-gb"

# Laptop specific
if [[ "${HOSTNAME}" == "juho-laptop" ]]; then
        INSTALL="${INSTALL}
        thinkfan
        i965-va-driver
        tlp"
fi

# ---

# Check for manually installed packages which are not needed
for x in $(apt-mark showmanual); do
        needed="0"
        for y in ${INSTALL}; do
                if [[ "${x}" == "${y}" ]]; then
                        needed="1"
                        break
                fi
        done

        if [[ "${needed}" == "0" ]]; then
                echo "${x} is marked manual but is not needed -> mark auto"
                apt-mark auto ${x} > /dev/null
        fi
done

# Check for not marked packages which are wanted
for x in ${INSTALL}; do
        echo "- ${x}?"
        installed=$(dpkg --get-selections ${x} | grep -q install)
        auto=$(apt-mark showauto ${x} | wc -l)
        if [[ "${installed}" == "1" ]]; then
                echo "  Not installed -> installing"
                apt-get install ${x}
        elif [[ "${auto}" == "1" ]]; then
                echo "  Automatically installed -> mark manual"
                apt-mark manual ${x} > /dev/null
        fi
done

# Uninstall unnecessary
# apt-get autoremove
