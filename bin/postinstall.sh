#!/bin/bash

. $HOME/.local/lib/functions.sh

header "Submodules"
if confirm -i "Update all submodules?"; then
    git submodule foreach git checkout
    git submodule foreach git pull
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

if [[ $HOSTNAME == "juho-desktop" ]] || [[ $HOSTNAME == "juho-laptop" ]]; then
    header "Build Ponymix"
    make -C $HOME/.local/modules/ponymix -j5
    header "Build Dunst"
    make -C $HOME/.local/modules/dunst -j5
    header "Build i3blocks"
    make -C $HOME/.local/modules/i3blocks -j5
fi

header "Systemfiles"
if confirm -i "Install systemfiles?"; then
    $HOME/.systemfiles/install.sh
fi
