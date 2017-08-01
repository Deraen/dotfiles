#!/bin/bash

. "$HOME/.local/lib/functions.sh"

desktop=false
if [[ $HOSTNAME == "juho-desktop" ]] || [[ $HOSTNAME == "juho-laptop" ]]; then
    desktop=true
fi

header "Submodules"
if confirm -i "Update all submodules?"; then
    ./update.sh
fi

# Update all submodules to version defined
# - Init any submodule which is not initialized
# - Init/Update also submodules inside submodules
git submodule update --init --recursive

header "NPM Utils"

NVM_DIR="/home/juho/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

nvm install stable
nvm alias default stable
# nvm use stable

(
cd "$HOME/.local"
if confirm -i "Update Node utils?"; then
    npm-check-updates --upgradeAll
fi
npm prune
npm install
npm update
)

header "Build vimproc"
make -C "$HOME/.vim/bundle/vimproc" -j

if [[ $desktop == true ]]; then
    header "Build Ponymix"
    make -C "$HOME/.local/modules/ponymix" -j
    header "Build Dunst"
    make -C "$HOME/.local/modules/dunst" -j
    header "Build i3blocks"
    make -C "$HOME/.local/modules/i3blocks" -j
    header "Build frakkin-xkb"
    make -C "$HOME/.local/modules/frakkin-xkb" -j
    header "Build i3-utils"
    make -C "$HOME/.local/modules/i3-utils" -j
    header "Build rofi"
    (
    cd "$HOME/.local/modules/rofi"
    autoreconf -i
    mkdir -p build
    cd build
    ../configure --prefix="$HOME/.local" --enable-drun
    make -j
    make install
    )

    header "Xss-lock"
    (
    cd "$HOME/.local/modules/xss-lock"
    mkdir -p build
    cd build
    cmake ..
    make -j
    )

    header "Settings"
    gsettings set org.gnome.desktop.background show-desktop-icons false
    crudini --set "$HOME/.config/Trolltech.conf" Qt style GTK+
    crudini --merge "$HOME/.config/keepassx/keepassx2.ini" < "$HOME/.config/keepassx/keepassx2.ini.sample"

    (
    cd $HOME
    # Home git repo, don't show untracked files on status
    git config status.showUntrackedFiles no
    )
fi

if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    header "Systemfiles"
    $HOME/.systemfiles/install.sh
fi
