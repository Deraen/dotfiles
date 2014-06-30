_lp_escape() {
    printf "%q" "$*"
}

_USER=""
if [[ "$USER" != "juho" ]]; then
    if [[ "$EUID" == "0" ]]; then
        _USER="%{$fg[red]%}"
    fi
    _USER="$_USER%n%{$reset_color%}@"
fi

_lp_connection() {
    if [[ -n "$SSH_CLIENT$SSH2_CLIENT$SSH_TTY" ]] ; then
        echo ssh
    else
        local sess_src="$(who am i | sed -n 's/.*(\(.*\))/\1/p')"
        local sess_parent="$(ps -o comm= -p $PPID 2> /dev/null)"
        if [[ -z "$sess_src" || "$sess_src" = ":"* ]] ; then
            echo lcl
        elif [[ "$sess_parent" = "su" || "$sess_parent" = "sudo" ]] ; then
            echo su
        else
            echo tel
        fi
    fi
}

_HOST=""
_chroot() {
    if [[ -r /etc/debian_chroot ]] ; then
        local debchroot
        debchroot="$(< /etc/debian_chroot)"
        echo "(${debchroot})"
    fi
}
_HOST="$(_chroot)"
unset _chroot

declare -A _HOST_COLORS
_HOST_COLORS[ssh]="%{$fg[blue]%}"
_HOST_COLORS[su]="%{$fg[yellow]%}"
_HOST_COLORS[tel]="%{$fg[red]%}"

_conn=$(_lp_connection)
if [[ $_conn == "lcl" ]]; then
    _HOST=""
else
    _HOST="${_HOST}$_HOST_COLORS[$_conn]%m%{$reset_color%}:"
fi

_END_CHAR="$"

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
    if [[ -n "$branch" ]]; then

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
        # only to check for uncommitted changes
        local shortstat
        shortstat="$(LC_ALL=C \git diff --shortstat HEAD 2>/dev/null)"

        if [[ -n "$shortstat" ]] ; then
            # shorstat of *unstaged* changes
            local u_stat
            u_stat="$(LC_ALL=C \git diff --shortstat 2>/dev/null)"
            # removing "n file(s) changed"
            u_stat=${u_stat/*changed, /}

            # inserted lines
            local i_lines
            if [[ "$u_stat" = *insertion* ]]; then
                i_lines=${u_stat/ inser*}
            else
                i_lines=0
            fi

            # deleted lines
            local d_lines
            if [[ "$u_stat" = *deletion* ]]; then
                d_lines=${u_stat/*\(+\), }
                d_lines=${d_lines/ del*/}
            else
                d_lines=0
            fi

            local has_lines
            has_lines="+$i_lines/-$d_lines"

            ret="%{$fg[red]%}$branch%{$reset_color%}(%F{013}$has_lines%{$reset_color%}"
            if [[ "$has_commit" -gt "0" ]]; then
                # Changes to commit and commits to push
                ret="$ret,%{$fg[yellow]%}$has_commit"
            fi
            ret="$ret%{$reset_color%})"
        else
            if [[ "$has_commit" -gt "0" ]]; then
                # some commit(s) to push
                ret="%{$fg[yellow]%}"
            else
                # nothing to commit or push
                ret="%{$fg[green]%}"
            fi

            ret="$ret$branch"

            if [[ "$has_commit" -gt "0" ]]; then
                ret="$ret%{$reset_color%}(%{$fg[yellow]%}$has_commit%{$reset_color%})"
            fi
        fi

        ret="$ret%{$reset_color%}"
        if LC_ALL=C \git status 2>/dev/null | grep -q '\(# Untracked\)'; then
            ret="$ret%{$fg[red]%}*$end"
        fi

        if [[ -n "$(\git stash list 2>/dev/null)" ]]; then
            ret="$ret%{$fg[yellow]%}+$end"
        fi

        echo -ne "$ret"
    fi
}

PROMPT='$_USER$_HOST%~ %{$fg[blue]%}$(_lp_git_branch_color)%{$fg[blue]%} % %{$reset_color%}$_END_CHAR '
