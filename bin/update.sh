#!/bin/bash

git submodule update --remote

( cd "$NVM_DIR" && git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" origin)" )
( cd "$HOME/.local/modules/alacritty" && git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" origin)" )

git add -A "$HOME/.local/modules" "$HOME/.vim/bundle*" "$HOME/.fzf"
