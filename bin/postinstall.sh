#!/bin/bash

set -e

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

curl https://get.volta.sh | bash
volta install node

(
cd "$HOME/.local" || exit

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

    header "Build i3-utils"
    make -C "$HOME/.local/modules/i3-utils" -j

    # (
    # cd "$HOME/.local/modules/wayland-protocols" || exit
    # header "Wayland-protocols"
    # if [[ ! -d build ]]; then
    #     meson setup build
    # fi
    # # ninja -C build
    # sudo ninja -C build install
    # )

    # (
    # cd "$HOME/.local/modules/wlroots" || exit
    # header "Wlroots"
    # if [[ ! -d build ]]; then
    #     meson setup -Dexamples=false build
    # fi
    # # ninja -C build
    # sudo ninja -C build install
    # )

    # Installed from apt
    # (
    # cd "$HOME/.local/modules/sway" || exit
    # header "Sway"
    # if [[ ! -d build ]]; then
    #     meson setup -D werror=false build
    # fi
    # if [[ ! -L subprojects/wlroots ]]; then
    #     mkdir -p subprojects
    #     ln -s $HOME/.local/modules/wlroots subprojects
    # fi
    # ninja -C build
    # sudo ninja -C build install
    # )

    (
    # Home git repo, don't show untracked files on status
    cd "$HOME" && git config status.showUntrackedFiles no
    )

    (
    header "Rust packages"
    cargo install just
    cargo install fd-find
    )

    # Installed from apt
    # (
    # cd "$HOME/.local/modules/alacritty" || exit
    # header "Alacritty"
    # cargo build --release
    # sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    # cp target/release/alacritty "$HOME/.local/bin/alacritty.new"
    # mv "$HOME/.local/bin/alacritty.new" "$HOME/.local/bin/alacritty"
    # mkdir -p "$HOME/.local/share/pixmaps/"
    # cp extra/logo/alacritty-term.svg "$HOME/.local/share/pixmaps/Alacritty.svg"
    # cp extra/linux/Alacritty.desktop "$HOME/.local/share/applications/Alacritty.desktop"
    # sudo mkdir -p /usr/local/share/man/man1
    # gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
    # gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
    # )

    (
    cd $HOME/.local/modules/idlehack || exit
    header "Idlehack"
    make
    )

    (
    cd $HOME/.local/modules/hyprpicker || exit
    header "Hyprpicker"
    make
    )

    header "Settings"
    gsettings set org.gnome.desktop.background show-desktop-icons false
    crudini --set "$HOME/.config/Trolltech.conf" Qt style GTK+

    # systemctl --user --now disable pulseaudio.service pulseaudio.socket
    systemctl --user --now enable pipewire pipewire-pulse
    systemctl --user --now enable wireplumber

    # Will run sway inhibit when chrome/firefox reports video etc. use to freedesktop
    # screensaver dbus API.
    systemctl --user --now enable idlehack

    # Hide gnome control panels that don't work with sway
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-color-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-multitasking-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-search-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-notifications-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-online-accounts-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-sharing-panel.desktop
    # sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-screen-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-background-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-display-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-mouse-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-keyboard-panel.desktop
    sudo dpkg-statoverride --force-statoverride-add --update --add root root 640 /usr/share/applications/gnome-region-panel.desktop

    if [[ -f /usr/lib/slack/resources/app.asar ]]; then
        header "Modify Slack binary to allow PipeWire"
        sudo sed -i 's|,"WebRTCPipeWireCapturer"|,"xxxxxxxxxxxxxxxxxxxxxx"|' /usr/lib/slack/resources/app.asar
    fi
fi

if [[ $desktop == true ]] && confirm -i "Install systemfiles?"; then
    header "Systemfiles"
    . "$HOME/.systemfiles/install.sh"
fi
