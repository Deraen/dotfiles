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

npm prune --no-fund --no-audit
npm install --no-fund
)

if [[ ! -d ~/.cargo ]]; then
    header "Install Rust"
    curl https://sh.rustup.rs -sSf | sh
fi

header "Update Rust"
rustup override set stable
rustup update stable

header "Install clojure"
clojure_tool_version=1.11.0.1100
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

    (
    cd "$HOME/.local/modules/wlroots" || exit
    header "Wlroots"
    meson build
    sudo ninja -C build install
    )

    (
    cd "$HOME/.local/modules/sway" || exit
    header "Sway"
    meson build
    if [[ ! -f subprojects/wlroots ]]; then
        mkdir -p subprojects
        ln -s $HOME/.local/modules/wlroots subprojects
    fi
    sudo ninja -C build install
    )

    (
    cd "$HOME/.local/modules/SwayNotificationCenter" || exit
    header "SwayNC"
    ninja -C build
    sudo meson install -C build
    sudo cp -r /usr/local/etc/xdg/swaync /etc/xdg/
    )

    (
    # Home git repo, don't show untracked files on status
    cd "$HOME" && git config status.showUntrackedFiles no
    )

    (
    cd "$HOME/.vim/bundle/vim-clap" || exit
    header "Vim-clap"
    cargo build --release
    )

    (
    header "Rust packages"
    cargo install just
    cargo install fd-find
    )

    (
    cd "$HOME/.local/modules/alacritty" || exit
    header "Alacritty"
    cargo build --release
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    cp target/release/alacritty "$HOME/.local/bin/alacritty.new"
    mv "$HOME/.local/bin/alacritty.new" "$HOME/.local/bin/alacritty"
    mkdir -p "$HOME/.local/share/pixmaps/"
    cp extra/logo/alacritty-term.svg "$HOME/.local/share/pixmaps/Alacritty.svg"
    cp extra/linux/Alacritty.desktop "$HOME/.local/share/applications/Alacritty.desktop"
    sudo mkdir -p /usr/local/share/man/man1
    gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
    gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
    )

    (
    cd $HOME/.local/modules/helvum || exit
    header "Helvum"
    meson setup build --prefix=$HOME/.local
    cd build || exit
    meson compile
    meson install
    )

    (
    cd $HOME/.local/modules/idlehack || exit
    header "Idlehack"
    make
    )

    go install go.mozilla.org/sops/v3/cmd/sops@latest

    header "Settings"
    gsettings set org.gnome.desktop.background show-desktop-icons false
    crudini --set "$HOME/.config/Trolltech.conf" Qt style GTK+

    systemctl --user --now disable pulseaudio.service pulseaudio.socket
    systemctl --user --now enable pipewire pipewire-pulse
    systemctl --user --now enable wireplumber

    # Will run sway inhibit when chrome/firefox reports video etc. use to freedesktop
    # screensaver dbus API.
    systemctl --user --now enable idlehack

    # Hide gnome control panels that don't work with sway
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-color-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-multitasking-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-search-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-notifications-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-online-accounts-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-sharing-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-screen-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-background-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-display-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-mouse-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-keyboard-panel.desktop
    sudo dpkg-statoverride --update --add root root 640 /usr/share/applications/gnome-region-panel.desktop
fi

if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    header "Systemfiles"
    . "$HOME/.systemfiles/install.sh"
fi
