# Setup fzf
# ---------
if [[ ! "$PATH" == */home/juho/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/juho/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/juho/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/juho/.fzf/shell/key-bindings.bash"
