# Deraen's dotfiles

Highly optionated setup using Ubuntu, i3, Zsh, Vim...

## Interesting files

| File | Description |
|------|-------------|
| [packages.sh](bin/packages.sh) | Install wanted packages and uninstall others
| [postinstall.sh](bin/postinstall.sh) | Update, fetch and build external modules (git submodules). Create some system config files.
| [dmenu.sh](bin/dmenu.sh) | Dmenu with list built from .desktop-files, sorted by most used.
| [displays.yaml](.config/displays.yaml) | Describe different monitor setups and their settings, for [my dspmgr](https://github.com/Deraen/dspmgr).

## Installation

Prerequisites: git, bash

```bash
git clone git@github.com:Deraen/dotfiles.git
cd dotfiles
shopt -s dotglob # bash, or
setopt globdots # zsh
cp -R * ~
cd ..
rm -rf dotfiles
postinstall.sh
```

## Bootstrapping a new Ubuntu system

```bash
apt-get install git wget
# install dotfiles repo
sudo bin/package.sh
sudo apt-get update
repeat 3, 5 untill everything is ok...
Now your Ubuntu should have packages selected in packages.sh
```
