#!/bin/bash

# Update all submodules to version defined
# - Init any submodule which is not initialized
# - Init/Update also submodules inside submodules
git submodule update --init --recursive

make -C $HOME/.vim/bundle/vimproc

mkdir $HOME/tmp/ycm_build
pushd $HOME/tmp/ycm_build
cmake -G "Unix Makefiles" . $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs -j5
popd

ln -s $HOME/.local/modules/tpm-filemanagement/filemanager.sh $HOME/.local/bin

if [[ $HOSTNAME == "juho-desktop" ]] || [[ $HOSTNAME == "juho-laptop" ]]; then
    make -C $HOME/.local/modules/ponymix -j5
    ln -s $HOME/.local/modules/ponymix/ponymix $HOME/.local/bin

    make -C $HOME/.local/modules/dunst -j5
    ln -s $HOME/.local/modules/dunst/dunst $HOME/.local/bin
fi

$HOME/.systemfiles/install.sh
