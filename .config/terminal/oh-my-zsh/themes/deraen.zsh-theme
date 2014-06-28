_lp_escape() {
    printf "%q" "$*"
}

_lp_git_branch() {
    local gitdir
    gitdir="$([ $(\git ls-files . 2>/dev/null | wc -l) -gt 0 ] && \git rev-parse --git-dir 2>/dev/null)"
    [[ $? -ne 0 || ! $gitdir =~ (.*\/)?\.git.* ]] && return
    local branch
    # Recent versions of Git support the --short option for symbolic-ref, but
    # not 1.7.9 (Ubuntu 12.04)
    if branch="$(\git symbolic-ref -q HEAD)"; then
        _lp_escape "${branch#refs/heads/}"
    else
        # In detached head state, use commit instead
        # No escape needed
        \git rev-parse --short -q HEAD
    fi
}

_lp_git_branch_color() {
    local branch
    branch="$(_lp_git_branch)"
    if [[ -n "$branch" ]] ; then

        local end
        end="%{$reset_color%}"
        if LC_ALL=C \git status 2>/dev/null | grep -q '\(# Untracked\)'; then
            end="%{$fg[red]%}$LP_MARK_UNTRACKED$end"
        fi

        if [[ -n "$(\git stash list 2>/dev/null)" ]]; then
            end="%{$fg[yellow]%}$LP_MARK_STASH$end"
        fi

        local remote
        remote="$(\git config --get branch.${branch}.remote 2>/dev/null)"

        local has_commit
        has_commit=0
        if [[ -n "$remote" ]] ; then
            local remote_branch
            remote_branch="$(\git config --get branch.${branch}.merge)"
            if [[ -n "$remote_branch" ]] ; then
                has_commit="$(\git rev-list --no-merges --count ${remote_branch/refs\/heads/refs\/remotes\/$remote}..HEAD 2>/dev/null)"
                if [[ -z "$has_commit" ]] ; then
                    has_commit=0
                fi
            fi
        fi

        local ret
        local shortstat # only to check for uncommitted changes
        shortstat="$(LC_ALL=C \git diff --shortstat HEAD 2>/dev/null)"

        if [[ -n "$shortstat" ]] ; then
            local u_stat # shorstat of *unstaged* changes
            u_stat="$(LC_ALL=C \git diff --shortstat 2>/dev/null)"
            u_stat=${u_stat/*changed, /} # removing "n file(s) changed"

            local i_lines # inserted lines
            if [[ "$u_stat" = *insertion* ]] ; then
                i_lines=${u_stat/ inser*}
            else
                i_lines=0
            fi

            local d_lines # deleted lines
            if [[ "$u_stat" = *deletion* ]] ; then
                d_lines=${u_stat/*\(+\), }
                d_lines=${d_lines/ del*/}
            else
                d_lines=0
            fi

            local has_lines
            has_lines="+$i_lines/-$d_lines"

            if [[ "$has_commit" -gt "0" ]] ; then
                # Changes to commit and commits to push
                ret="%{$fg[red]%}${branch}%{$reset_color%}(%F{013}$has_lines%{$reset_color%},%{$fg[yellow]%}$has_commit%{$reset_color%})"
            else
                ret="%{$fg[red]%}${branch}%{$reset_color%}(%F{013}$has_lines%{$reset_color%})" # changes to commit
            fi
        else
            if [[ "$has_commit" -gt "0" ]] ; then
                # some commit(s) to push
                ret="%{$fg[yellow]%}${branch}%{$reset_color%}(%{$fg[yellow]%}$has_commit%{$reset_color%})"
            else
                ret="%{$fg[green]%}${branch}" # nothing to commit or push
            fi
        fi
        echo -ne "$ret$end"
    fi
}

PROMPT='%{$fg[green]%}%p %{$fg[cyan]%}%c %{$fg[blue]%}$(_lp_git_branch_color)%{$fg[blue]%} % %{$reset_color%}$ '
