#!/bin/bash

. $HOME/.local/lib/functions.sh

desktop=false
if [[ $HOSTNAME == "juho-desktop" ]] || [[ $HOSTNAME == "juho-laptop" ]]; then
    desktop=true
fi

header "Submodules"
if confirm -i "Update all submodules?"; then
    git submodule foreach git checkout
    git submodule foreach git pull origin master
    # Updated modules have to be added to the index, or the next step would undo this
    git add -A $HOME/.local/modules $HOME/.vim/bundle
fi

# Update all submodules to version defined
# - Init any submodule which is not initialized
# - Init/Update also submodules inside submodules
git submodule update --init --recursive

header "NPM Utils"
(
cd $HOME/.local
if confirm -i "Update Node utils?"; then
    npm-check-updates -u
fi
npm prune
npm install
)

header "Build vimproc"
make -C $HOME/.vim/bundle/vimproc -j

header "Neovim Python virtualenv"

(
cd $HOME/.local/virtualenvs
if [[ ! -f neovim/bin/activate ]]; then
    python3 -m venv neovim
fi
source neovim/bin/activate
pip3 install -r neovim/requirements.txt

if confirm -i "Update neovim python packages?"; then
    pip3 install `pip freeze -l | cut --fields=1 -d = -` --upgrade
    pip3 freeze > neovim/requirements.txt
fi
)

if [[ $desktop == true ]]; then
    header "Build Ponymix"
    make -C $HOME/.local/modules/ponymix -j
    header "Build Dunst"
    make -C $HOME/.local/modules/dunst -j
    header "Build i3blocks"
    make -C $HOME/.local/modules/i3blocks -j
    header "Build frakkin-xkb"
    make -C $HOME/.local/modules/frakkin-xkb -j
    header "Build i3-utils"
    make -C $HOME/.local/modules/i3-utils -j
    header "Build rofi"
    (
    cd $HOME/.local/modules/rofi
    autoreconf -i
    mkdir -p build
    cd build
    ../configure --prefix=$HOME/.local
    make -j
    make install
    )

    header "Xss-lock"
    (
    cd $HOME/.local/modules/xss-lock
    mkdir -p build
    cd build
    cmake ..
    make -j
    )

    header "Settings"
    gsettings set org.gnome.desktop.background show-desktop-icons false
    crudini --set $HOME/.config/Trolltech.conf Qt style GTK+
    crudini --merge $HOME/.config/keepassx/keepassx2.ini < $HOME/.config/keepassx/keepassx2.ini.sample

    (
    cd $HOME
    # Home git repo, don't show untracked files on status
    git config status.showUntrackedFiles no
    )
fi

header "Systemfiles"
if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    $HOME/.systemfiles/install.sh
fi
