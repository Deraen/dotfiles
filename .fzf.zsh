# Setup fzf
# ---------
if [[ ! "$PATH" == */home/juho/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/juho/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/juho/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/juho/.fzf/shell/key-bindings.zsh"
