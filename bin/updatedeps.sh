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

git add -A "$HOME/.local/modules" "$HOME/.vim/bundle*" "$HOME/.fzf" "$HOME/.nvm"

if confirm -i "Update Node utils?"; then
    (
    cd "$HOME/.local" || exit
    ncu -u
    npm install
    )
fi

# TODO: Docker-compose 2?
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64" -o /home/juho/bin/docker-compose
chmod +x /home/juho/bin/docker-compose

bash <(curl -s https://raw.githubusercontent.com/borkdude/jet/master/install) /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/borkdude/clj-kondo/master/script/install-clj-kondo) --dir /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/babashka/babashka/master/install) --dir /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/greglook/cljstyle/main/script/install-cljstyle) --dir /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install) --dir /home/juho/bin

postinstall.sh
