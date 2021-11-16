#!/bin/bash

. "$HOME/.local/lib/functions.sh"

desktop=false
if [[ $(hostname -s) =~ juho-(desktop|laptop) ]]; then
    echo Using desktop setup
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

nvm install stable

npm prune
npm install
npm update
)

if [[ ! -d ~/.cargo ]]; then
    header "Install Rust"
    curl https://sh.rustup.rs -sSf | sh
fi

header "Update Rust"
rustup override set stable
rustup update stable

header "Build vimproc"
make -C "$HOME/.vim/bundle/vimproc" -j

header "Install clojure"
clojure_tool_version=1.10.3.855
clojure_bin=$HOME/.local/bin/clojure

if [[ ! -f $clojure_bin ]] || ! grep -q "# Version = $clojure_tool_version" "$clojure_bin"; then
    curl "https://download.clojure.org/install/linux-install-$clojure_tool_version.sh" \
        -o /tmp/clojure-installer.sh
    chmod +x /tmp/clojure-installer.sh
    /tmp/clojure-installer.sh --prefix "$HOME/.local"
    rm /tmp/clojure-installer.sh
fi

header "Update FZF"
./.fzf/install --update-rc --completion --key-bindings

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
    # meson -Dprefix="$HOME/.local" --buildtype=release . build
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

    (
    cd "$HOME/.local/modules/alacritty" || exit
    cargo build --release
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    cp target/release/alacritty "$HOME/.local/bin/alacritty.new"
    mv "$HOME/.local/bin/alacritty.new" "$HOME/.local/bin/alacritty"
    mkdir -p "$HOME/.local/share/pixmaps/"
    cp extra/logo/alacritty-term.svg "$HOME/.local/share/pixmaps/Alacritty.svg"
    cp extra/linux/Alacritty.desktop "$HOME/.local/share/applications/Alacritty.desktop"
    sudo mkdir -p /usr/local/share/man/man1
    gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
    )
fi

if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    header "Systemfiles"
    . "$HOME/.systemfiles/install.sh"
fi
