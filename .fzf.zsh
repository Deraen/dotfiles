# Setup fzf
# ---------
if [[ ! "$PATH" == */home/juho/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/juho/.fzf/bin"
fi

source <(fzf --zsh)
