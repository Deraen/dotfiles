#!/bin/bash

. $HOME/.local/lib/functions.sh

header "Submodules"
if confirm -i "Update all submodules?"; then
    git submodule foreach git pull
fi

# Update all submodules to version defined
# - Init any submodule which is not initialized
# - Init/Update also submodules inside submodules
git submodule update --init --recursive

header "Build vimproc"
make -C $HOME/.vim/bundle/vimproc

header "Build YCM"
mkdir $HOME/tmp/ycm_build
pushd $HOME/tmp/ycm_build
cmake -G "Unix Makefiles" . $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs -j5
popd

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
