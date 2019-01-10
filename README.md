# Deraen's dotfiles

Highly customized setup using Ubuntu, i3, Zsh, Vim...

- I try to include as few files as possible
- ... while including all files I would need with a new computer

## Submodules

I'm using git submodules to manage external packages like Vim plugins and few programs which are
not available as Debian packages. Following command is useful to check changes (shortlog) of each
changed submodule after updating submodules: `git log -p --submodule=log` or
`git submodule summary`.

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

### Remove automatically added Chrome search engines

Only leave search engines where keyword doesn't contain dots, i.e. keyword is not the domain:

```js
settings.SearchEnginesBrowserProxyImpl.prototype.getSearchEnginesList()
    .then(function(val) {
        val.others.sort(function(a, b) { return b.modelIndex - a.modelIndex; });
        val.others.forEach(function(engine) {
            if (engine.keyword.indexOf('.') !== -1) {
                settings.SearchEnginesBrowserProxyImpl.prototype.removeSearchEngine(engine.modelIndex);
            }
        });
    });
```
