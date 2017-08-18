#!/bin/bash

if [[ -f $HOME/Source/termite-install/termite ]]; then
    TERMINFO=$HOME/.local/share/terminfo LD_LIBRARY_PATH=$HOME/Source/termite-install:$LD_LIBRARY_PATH $HOME/Source/termite-install/termite $@
else
    urxvt.sh $@
fi