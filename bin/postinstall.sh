#!/bin/bash

# Update all submodules to version defined
# - Init any submodule which is not initialized
# - Init/Update also submodules inside submodules
git submodule update --init --recursive

make -C $HOME/.vim/bundle/vimproc

pushd $HOME/.vim/bundle/YouCompleteMe
./install.sh
popd

make -C $HOME/.local/modules/ponymix
ln -s $HOME/.local/modules/ponymix/ponymix $HOME/.local/bin

make -C $HOME/.local/modules/dunst
ln -s $HOME/.local/modules/dunst/dunst $HOME/.local/bin

$HOME/.systemfiles/install.sh
