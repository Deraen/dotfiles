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
make -C $HOME/.vim/bundle/vimproc

header "Build YCM"
(
mkdir -p $HOME/tmp/ycm_build
cd $HOME/tmp/ycm_build
cmake -G "Unix Makefiles" . $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs -j5
)

header "Install boot"
(
cd $HOME/bin
if [ ! -f boot ]; then
    curl -L https://github.com/boot-clj/boot/releases/download/v2-r1/boot.sh -o boot
    chmod +x boot
else
    boot -u
fi
)

if [[ $desktop == true ]]; then
    header "Build Ponymix"
    make -C $HOME/.local/modules/ponymix -j5
    header "Build Dunst"
    make -C $HOME/.local/modules/dunst -j5
    header "Build i3blocks"
    make -C $HOME/.local/modules/i3blocks -j5
    header "Build St"
    cp $HOME/.config/st.config.h $HOME/.local/modules/st/config.h
    make -C $HOME/.local/modules/st -j5
fi

header "Systemfiles"
if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    $HOME/.systemfiles/install.sh
fi
