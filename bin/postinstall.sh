#!/bin/bash

. "$HOME/.local/lib/functions.sh"

desktop=false
if [[ $HOSTNAME == "juho-desktop" ]] ||
    [[ $HOSTNAME == "juho-ThinkPad-T490" ]] ||
    [[ $HOSTNAME == "juho-laptop" ]]; then
    desktop=true
fi

header "Submodules"
if confirm -i "Update all submodules?"; then
    ./update.sh
fi

# Update all submodules to version defined
# - Init any submodule which is not initialized
# - Init/Update also submodules inside submodules
git submodule update --init --recursive

header "NPM Utils"

(
cd "$HOME/.local" || exit
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if confirm -i "Update Node utils?"; then
    npm-check-updates --upgradeAll
fi
npm prune
npm install
npm update
)

if confirm -i "Update Docker-compose?"; then
    version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".name")
    curl -s -L --fail "https://github.com/docker/compose/releases/download/$version/run.sh" > "$HOME/bin/docker-compose"
    chmod +x "$HOME/bin/docker-compose"
fi

if [[ ! -d ~/.cargo ]]; then
    header "Install Rust"
    curl https://sh.rustup.rs -sSf | sh
fi

header "Update Rust"
rustup update

header "Build vimproc"
make -C "$HOME/.vim/bundle/vimproc" -j

header "Install clojure"
clojure_tool_version=1.10.1.447
clojure_bin=$HOME/.local/bin/clojure

if [[ ! -f $clojure_bin ]] || ! grep -q "# Version = $clojure_tool_version" "$clojure_bin"; then
    curl "https://download.clojure.org/install/linux-install-$clojure_tool_version.sh" \
        -o /tmp/clojure-installer.sh
    chmod +x /tmp/clojure-installer.sh
    /tmp/clojure-installer.sh --prefix "$HOME/.local"
    rm /tmp/clojure-installer.sh
fi

# Rebuild zsh completion
# rm -f ~/.zcompdump; compinit

if [[ $desktop == true ]]; then
    header "Build Ponymix"
    make -C "$HOME/.local/modules/ponymix" -j
    header "Build frakkin-xkb"
    make -C "$HOME/.local/modules/frakkin-xkb" -j
    header "Build i3-utils"
    make -C "$HOME/.local/modules/i3-utils" -j

    header "Alacritty"
    (
    cd "$HOME/.local/modules/alacritty" || exit
    cargo build --release
    sudo tic -e alacritty,alacritty-direct extra/alacritty.info
    mv target/release/alacritty "$HOME/.local/bin/alacritty"
    )

    header "Settings"
    gsettings set org.gnome.desktop.background show-desktop-icons false
    crudini --set "$HOME/.config/Trolltech.conf" Qt style GTK+

    (
    # Home git repo, don't show untracked files on status
    cd "$HOME" && git config status.showUntrackedFiles no
    )
fi

if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    header "Systemfiles"
    . "$HOME/.systemfiles/install.sh"
fi
