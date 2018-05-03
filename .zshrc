fpath=( "$HOME/.config/terminal/zfunctions" "$HOME/.local/modules/zsh-completions/src" $fpath )

# Use history
HISTFILE=$HOME/.zsh_history

# Load Pure prompt
autoload -U promptinit && promptinit
PURE_GIT_PULL=0
prompt pure

# Search history
bindkey '^R' history-incremental-search-backward

# Backward delete to slash
autoload -U select-word-style
select-word-style bash

# Ctrl + left/right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Automatically escape ?&= on urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Complete .. -> ../
zstyle ':completion:*' special-dirs true
# Show some colors on complete
zstyle ':completion:*' list-colors ''

# Load common shell options
source $HOME/.config/terminal/common.sh

# Color commands
source $HOME/.local/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ $TERM == xterm-termite ]]; then
  # . /etc/profile.d/vte.sh
  . $HOME/Source/termite-install/vte.sh
  __vte_osc7
fi

__git_files () {
  local compadd_opts opts tag description gitcdup gitprefix files expl

  zparseopts -D -E -a compadd_opts V: J: 1 2 n f X: M: P: S: r: R: q F:

  untracked=$(_call_program untracked git config --local status.showUntrackedFiles)
  __git_command_successful $pipestatus || return 1
  if [[ $untracked != "no" ]]; then
    others="-others"
  fi

  zparseopts -D -E -a opts -- -cached -deleted -modified $others -ignored -unmerged -killed x+: --exclude+:
  tag=$1 description=$2; shift 2

  gitcdup=$(_call_program gitcdup git rev-parse --show-cdup 2>/dev/null)
  __git_command_successful $pipestatus || return 1

  gitprefix=$(_call_program gitprefix git rev-parse --show-prefix 2>/dev/null)
  __git_command_successful $pipestatus || return 1

  # TODO: --directory should probably be added to $opts when --others is given.
  local pref=$gitcdup$gitprefix$PREFIX

  # First allow ls-files to pattern-match in case of remote repository
  files=(${(0)"$(_call_program files git ls-files -z --exclude-standard $opts -- ${pref:+$pref\ \\*} 2>/dev/null)"})
  __git_command_successful $pipestatus || return

  # If ls-files succeeded but returned nothing, try again with no pattern
  if [[ -z "$files" && -n "$pref" ]]; then
    files=(${(0)"$(_call_program files git ls-files -z --exclude-standard $opts -- 2>/dev/null)"})
    __git_command_successful $pipestatus || return
  fi

#  _wanted $tag expl $description _files -g '{'${(j:,:)files}'}' $compadd_opts -
  _wanted $tag expl $description _multi_parts -f $compadd_opts - / files
}
