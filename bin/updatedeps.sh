#!/bin/bash

. "$HOME/.local/lib/functions.sh"

declare -A old_version

get_lastest_tag() {
    old_version[$1]=1
    (
    cd "$1" || exit

    git fetch --tags
    latest_tag_sha=$(git rev-list --tags --max-count=1)
    tag=$(git describe --abbrev=0 --tags "$latest_tag_sha")
    echo "# $(basename "$1") checkout $tag"
    git checkout "$tag"
    echo
    )
}

get_lastest_tag "$HOME/.fzf"
get_lastest_tag "$HOME/.local/modules/wlroots"
get_lastest_tag "$HOME/.local/modules/sway"
get_lastest_tag "$HOME/.local/modules/alacritty"
get_lastest_tag "$HOME/.local/modules/SwayNotificationCenter"

declare -a paths

OFS=$IFS
IFS=$'\n'
for status in $(git submodule status); do
    repo=$HOME/$(echo $status | cut -c 2- | cut -d' ' -f2)
    version=$(echo $status | cut -c 2- | cut -d' ' -f3)

    # Skip updating those that already have latest tag
    if [[ ${old_version[$repo]+_} ]]; then
        old_version[$repo]=$version
        continue
    fi

    old_version[$repo]=$version
    paths+=( $repo )
done

git submodule update --remote ${paths[@]}

for status in $(git submodule status); do
    repo=$HOME/$(echo $status | cut -c 2- | cut -d' ' -f2)
    new_version=$(echo $status | cut -c 2- | cut -d' ' -f3)
    o=${old_version[$repo]}
    if [[ "$o" != "$new_version" ]]; then
        echo "Updated $repo from $o to $new_version"
    fi
done


git add -A "$HOME/.local/modules" "$HOME/.fzf"

if confirm -i "Update Node utils?"; then
    (
    cd "$HOME/.local" || exit
    ncu -u
    npm install
    )
fi

# TODO: Rest should be on postinstall
bash <(curl -s https://raw.githubusercontent.com/borkdude/jet/master/install) /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/borkdude/clj-kondo/master/script/install-clj-kondo) --dir /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/babashka/babashka/master/install) --dir /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/greglook/cljstyle/main/script/install-cljstyle) --dir /home/juho/bin
bash <(curl -s https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh) -b /home/juho/bin

wget -O ~/bin/nvim.appimage.new https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
mv ~/bin/nvim.appimage.new ~/bin/nvim.appimage
chmod +x ~/bin/nvim.appimage
nvim.appimage --version

wget -o ~/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/download/latest/yt-dlp_linux
chmod +x ~/bin/yt-dlp

wget https://github.com/ko1nksm/shdotenv/releases/latest/download/shdotenv -O $HOME/.local/bin/shdotenv
chmod +x $HOME/.local/bin/shdotenv

SOPS_VERSION=$(wget -q -O - https://api.github.com/repos/getsops/sops/releases/latest | jq -r '.name')
wget -O ~/.local/bin/sops.new "https://github.com/getsops/sops/releases/download/$SOPS_VERSION/sops-$SOPS_VERSION.linux.amd64"
mv ~/.local/bin/sops.new ~/.local/bin/sops
chmod +x $HOME/.local/bin/sops

(
cd .fonts
curl -s 'https://api.github.com/repos/be5invis/Iosevka/releases/latest' | jq -r ".assets[] | .browser_download_url" | grep -E 'ttf-iosevka-(term-)?ss06' | xargs -n 1 curl -L -O --fail --silent --show-error
rm Iosevka*.ttf ttf-iosevka*.ttf
for i in ttf-iosevka*.zip; do
    unzip $i
    rm  $i
done
)

postinstall.sh
