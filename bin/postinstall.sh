#!/bin/bash

. "$HOME/.local/lib/functions.sh"

desktop=false
if [[ $(hostname -s) == "juho-desktop" ]] || [[ $(hostname -s) == "juho-laptop" ]]; then
    desktop=true
fi

# Update all submodules to version defined
# - Init any submodule which is not initialized
# - Init/Update also submodules inside submodules
git submodule update --init --recursive

header "NPM Utils"

(
cd "$HOME/.local" || exit
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

npm prune
npm install
npm update
)

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

    header "Build picom"
    (
    cd "$HOME/.local/modules/picom" || exit
    meson -Dprefix="$HOME/.local" --buildtype=release . build
    ninja -C build install
    )

    header "Settings"
    gsettings set org.gnome.desktop.background show-desktop-icons false
    crudini --set "$HOME/.config/Trolltech.conf" Qt style GTK+

    (
    # Home git repo, don't show untracked files on status
    cd "$HOME" && git config status.showUntrackedFiles no
    )

    (
    cd "$HOME/.vim/bundle/vim-clap" || exit
    cargo build --release
    )
fi

if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    header "Systemfiles"
    . "$HOME/.systemfiles/install.sh"
fi
