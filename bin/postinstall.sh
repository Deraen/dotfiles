#!/bin/bash

. "$HOME/.local/lib/functions.sh"

desktop=false
if [[ $HOSTNAME == "juho-desktop" ]] || [[ $HOSTNAME == "juho-laptop" ]]; then
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
cd "$HOME/.local"
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

header "Build vimproc"
make -C "$HOME/.vim/bundle/vimproc" -j

header "Install clojure"
clojure_tool_version=1.9.0.358
clojure_bin=$HOME/.local/bin/clojure

if [[ ! -f $clojure_bin ]] || ! grep -q "# Version = $clojure_tool_version" "$clojure_bin"; then
    curl "https://download.clojure.org/install/linux-install-$clojure_tool_version.sh" \
        -o /tmp/clojure-installer.sh
    chmod +x /tmp/clojure-installer.sh
    /tmp/clojure-installer.sh --prefix "$HOME/.local"
    rm /tmp/clojure-installer.sh
fi

if [[ $desktop == true ]]; then
    header "Build Ponymix"
    make -C "$HOME/.local/modules/ponymix" -j
    header "Build Dunst"
    make -C "$HOME/.local/modules/dunst" -j
    header "Build i3blocks"
    make -C "$HOME/.local/modules/i3blocks" -j
    header "Build frakkin-xkb"
    make -C "$HOME/.local/modules/frakkin-xkb" -j
    header "Build i3-utils"
    make -C "$HOME/.local/modules/i3-utils" -j
    header "Build rofi"
    (
    cd "$HOME/.local/modules/rofi"
    autoreconf -i
    mkdir -p build
    cd build
    ../configure --prefix="$HOME/.local" --enable-drun --disable-check
    make -j
    make install
    )

    header "Xss-lock"
    (
    cd "$HOME/.local/modules/xss-lock"
    mkdir -p build
    cd build
    cmake ..
    make -j
    )

    header "Alacritty"
    (
    cd "$HOME/Source/alacritty"
    cargo build --release
    cp target/release/alacritty "$HOME/.local/bin/alacritty"
    )

    header "Settings"
    gsettings set org.gnome.desktop.background show-desktop-icons false
    crudini --set "$HOME/.config/Trolltech.conf" Qt style GTK+
    crudini --merge "$HOME/.config/keepassx/keepassx2.ini" < "$HOME/.config/keepassx/keepassx2.ini.sample"

    (
    # Home git repo, don't show untracked files on status
    cd "$HOME" && git config status.showUntrackedFiles no
    )
fi

if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    header "Systemfiles"
    . "$HOME/.systemfiles/install.sh"
fi
