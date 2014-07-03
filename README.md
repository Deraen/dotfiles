# Juho's dotfiles

# Normal use

Prerequisites: git, bash

1. git clone git@github.com:Deraen/dotfiles.git
2. cd dotfiles
3. * by default doesn't include files starting with .
    - bash: `shopt -s dotglob`
    - zsh: `setopt globdots`
4. cp -R * ~
5. cd ..
6. rm -rf dotfiles

# Bootstrap a new Ubuntu system

1. apt-get install git wget
2. normal use 1-6
3. sudo bin/package.sh
4. sudo launchpad-getkeys # If new repos got added
5. sudo apt-get update
5. repeat 3, 5 untill everything is ok...
6. sudo apt-get autoremove
7. Now your Ubuntu should have packages selected in packages.sh
