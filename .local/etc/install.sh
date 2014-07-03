#!/bin/bash

installLink() {
    sudo ln -is $HOME/.local/etc/$1 /etc/$1
}

installLink "X11/xorg.conf.d/10-keyboard.conf"
