#!/bin/bash

cd ~/.fonts || exit
curl -s 'https://api.github.com/repos/be5invis/Iosevka/releases/latest' | jq -r ".assets[] | .browser_download_url" | grep -E 'PkgTTF-Iosevka(Term)?SS06' | xargs -n 1 curl -L -O --fail --silent --show-error
rm Iosevka*.ttf
for i in PkgTTF-*.zip; do
    unzip "$i"
    rm "$i"
done

if [[ ! -f ~/Downloads/FontForge-2023-01-01-a1dad3e-x86_64.AppImage ]]; then
    curl --location https://github.com/fontforge/fontforge/releases/download/20230101/FontForge-2023-01-01-a1dad3e-x86_64.AppImage \
        -o ~/Downloads/FontForge-2023-01-01-a1dad3e-x86_64.AppImage
    chmod +x ~/Downloads/FontForge-2023-01-01-a1dad3e-x86_64.AppImage
fi

if [[ ! -d ~/Downloads/font-patcher/ ]]; then
    (
    curl https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip \
        -o ~/Downloads/FontPatcher.zip
    mkdir -p ~/Downloads/font-patcher/
    cd ~/Downloads/font-patcher/ || exit
    unzip ~/Downloads/FontPatcher.zip
    )
fi

if [[ ! -f ~/Downloads/NerdFontsSymbolsOnly.zip ]]; then
    curl --location https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/NerdFontsSymbolsOnly.zip \
        -o ~/Downloads/NerdFontsSymbolsOnly.zip
fi
unzip ~/Downloads/NerdFontsSymbolsOnly.zip
