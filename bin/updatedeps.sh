#!/bin/bash

. "$HOME/.local/lib/functions.sh"

git submodule update --remote

get_lastest_tag() {
    (
    cd "$1" || exit
    tag=$(git describe --abbrev=0 --tags --match "[v0-9]*" origin)
    echo "$(basename "$1") checkout $tag"
    git checkout "$tag"
    )
}

get_lastest_tag "$NVM_DIR"
get_lastest_tag "$HOME/.fzf"
get_lastest_tag "$HOME/.local/modules/picom"
get_lastest_tag "$HOME/.vim/bundle/vim-go"
get_lastest_tag "$HOME/.vim/bundle/vim-clap"
get_lastest_tag "$HOME/.vim/bundle_clojure/vim-iced"

git add -A "$HOME/.local/modules" "$HOME/.vim/bundle*" "$HOME/.fzf" "$HOME/.nvm"

if confirm -i "Update Node utils?"; then
    (
    cd "$HOME/.local" || exit
    ncu -u
    npm install
    )
fi

if confirm -i "Update Docker-compose?"; then
    version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".name")
    curl -s -L --fail "https://github.com/docker/compose/releases/download/$version/run.sh" > "$HOME/bin/docker-compose"
    chmod +x "$HOME/bin/docker-compose"
fi

bash <(curl -s https://raw.githubusercontent.com/borkdude/jet/master/install) /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/borkdude/clj-kondo/master/script/install-clj-kondo) --dir /home/juho/bin

postinstall.sh
