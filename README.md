# Deraen's dotfiles

Highly customized setup using Ubuntu, i3, Zsh, Vim

- I try to include as few files as possible
- while including all files I would need with a new computer

## Submodules

I'm using git submodules to manage external packages like Vim plugins and a few programs which are
not available as Debian packages. Following command is useful to check changes (shortlog) of each
changed submodule after updating submodules: `git log -p --submodule=log` or
`git submodule summary`.

## Interesting files

| File | Description |
|------|-------------|
| [packages.sh](bin/packages.sh) | Install wanted packages and uninstall others
| [postinstall.sh](bin/postinstall.sh) | Update, fetch and build external modules (git submodules). Create some system config files.

## Installation

Prerequisites: git, bash

```bash
git clone --recurse-submodules git@github.com:Deraen/dotfiles.git
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
apt-get install git
# install dotfiles repo
sudo bin/packages.sh
sudo apt-get update
```

## Notes

```
# Remove old packages
dpkg -l | grep oibaf | awk '{print $2}' | xargs sudo dpkg --remove --force-all
```

## TODO

- Hyprland?
