alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias apt-add-key='apt-key adv --keyserver keyserver.ubuntu.com --recv-keys '
alias ccze="ccze -A"
alias o="open.sh"
# Open new terminal in current dir
alias term="( urxvt & ) &>/dev/null"

_add_vim_plugin() {
  $(cd $HOME ; git submodule add https://github.com/${1}.git .vim/bundle/${1##*/})
}
alias add-vim-plugin="_add_vim_plugin"
