#!/bin/bash

git submodule update --remote

( cd "$NVM_DIR" && git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" origin)" )
( cd "$HOME/.local/modules/alacritty" && git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" origin)" )

git add -A "$HOME/.local/modules" "$HOME/.vim/bundle*" "$HOME/.fzf"

if confirm -i "Update Node utils?"; then
    npm-check-updates --upgradeAll
fi

if confirm -i "Update Docker-compose?"; then
    version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".name")
    curl -s -L --fail "https://github.com/docker/compose/releases/download/$version/run.sh" > "$HOME/bin/docker-compose"
    chmod +x "$HOME/bin/docker-compose"
fi

./postinstall.sh
