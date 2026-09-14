# gitmux() and wt() were mostly vibe-coded

gitmux() {
    local -a rows session_rows inactive_repos
    local -A active_sessions
    local name dir base tmux_session description
    local tab=$'\t'

    while IFS=$'\t' read -r name dir; do
        [[ -n $name ]] || continue
        [[ -n $dir ]] || dir=$HOME
        active_sessions[$name]=1
        session_rows+=("$dir$tab $name$tab$name")
    done < <(tmux list-sessions -F $'#{session_name}\t#{session_path}' 2>/dev/null)

    while IFS= read -r dir; do
        dir=${dir%/.git/}
        dir=${dir%/.git}
        [[ -d $dir ]] || continue
        base=${dir:t}
        tmux_session=${base//[^a-zA-Z0-9]/_}
        description="󰉋 $base"
        if (( ! ${+active_sessions[$tmux_session]} )); then
            inactive_repos+=("$dir$tab$description$tab$tmux_session")
        fi
    done < <(fd -I -H --type d '^\.git$' ~/dev ~ -d 2 2>/dev/null | sort -u)

    rows=("${session_rows[@]}" "${inactive_repos[@]}")

    local selection
    selection=$(printf '%s\n' "${rows[@]}" \
        | fzf --multi --with-nth=2 --delimiter="$tab" --query="$*" \
            --header="enter: open workspace · C-x: kill · C-n: detached · C-r: refresh" \
            --expect=ctrl-x,ctrl-n,ctrl-r \
            --preview='p={1}; cd "$p" 2>/dev/null || exit; if command -v eza >/dev/null 2>&1; then eza --tree --level=2 --all --git-ignore --icons --color=always -- . | sed -E "s#^\\./##" | grep -vFx .; elif command -v lsd >/dev/null 2>&1; then lsd --tree --depth 2 --icon always --ignore-glob .git . | sed -E "s#^\\./##" | grep -vFx .; elif command -v fd >/dev/null 2>&1; then fd -I -H --max-depth 2 --exclude .git . . 2>/dev/null | sed -E "s#^\\./##" | grep -vFx .; else find . -not -path "./.git*" -print 2>/dev/null | sed -E "s#^\\./##" | grep -vFx .; fi' \
            --preview-window="right:50%") || return

    local -a lines items fields
    lines=("${(@f)selection}")
    local key=$lines[1]
    items=("${lines[2,-1]}")

    case "$key" in
        ctrl-x|ctrl-n)
            local item f s
            for item in "${items[@]}"; do
                fields=("${(@ps:$tab:)item}")
                f=$fields[1]; s=$fields[3]
                [[ -n $s ]] || continue
                if [[ $key == ctrl-x ]]; then
                    tmux kill-session -t "$s" 2>/dev/null && echo "Killed: $s"
                else
                    tmux has-session -t "$s" 2>/dev/null || tmux new-session -ds "$s" -c "$f"
                    echo "Created: $s"
                fi
            done
            gitmux ;;
        ctrl-r) gitmux ;;
        *)
            fields=("${(@ps:$tab:)items[1]}")
            dir=$fields[1]; s=$fields[3]
            [[ -n $dir ]] || return
            tmux has-session -t "$s" 2>/dev/null || tmux new-session -ds "$s" -c "$dir"
            if [[ -z $TMUX ]]; then
                tmux attach -t "$s"
            else
                tmux switch-client -t "$s"
            fi ;;
    esac
}

bindkey -s '^f' 'gitmux\n'

wt() {
    if [[ $1 == -h || $1 == --help || $1 == help ]]; then
        print -r -- 'wt - manage git worktrees as siblings of the repo (<repo>-<branch>)

usage:
  wt new <branch>   create a worktree + branch, then cd into it
  wt rm [<branch>]  remove a worktree by name; no arg opens an fzf picker
  wt                fzf-pick a worktree and cd into it (aliases: list, ls, cd)
  wt -h             show this help'
        return 0
    fi

    local root
    root=$(git rev-parse --show-toplevel 2>/dev/null) || {
        print -u2 "wt: not inside a git repo"; return 1
    }
    local repo=${root:t} parent=${root:h}
    local cmd=$1; shift 2>/dev/null

    case "$cmd" in
        new)
            local branch=$1
            [[ -n $branch ]] || { print -u2 "wt: usage: wt new <branch>"; return 1 }
            local wtdir="$parent/$repo-${branch//\//-}"
            git worktree add -b "$branch" "$wtdir" 2>/dev/null \
                || git worktree add "$wtdir" "$branch" \
                || return 1
            builtin cd -- "$wtdir"
            ;;
        rm|remove)
            local target=$1 wtdir
            if [[ -n $target ]]; then
                wtdir="$parent/$repo-${target//\//-}"
            else
                wtdir=$(git worktree list | fzf --with-nth=1 \
                    --preview 'git -C {1} status --short' \
                    --preview-window="right:50%")
                wtdir=${wtdir%% *}
            fi
            [[ -n $wtdir ]] || return 1
            local list="$(git worktree list)"
            local main=${${(f)list}[1]%% *}
            if git worktree remove "$wtdir"; then
                print "Removed: $wtdir"
                [[ -n $main ]] && builtin cd -- "$main"
                return
            fi
            print -u2 "wt: worktree dirty; retry with: git worktree remove --force $wtdir"
            return 1
            ;;
        ""|list|ls|cd)
            local wtdir
            wtdir=$(git worktree list | fzf --with-nth=1 \
                --preview 'git -C {1} log --oneline -8 2>/dev/null; echo; git -C {1} status --short 2>/dev/null' \
                --preview-window="right:50%")
            wtdir=${wtdir%% *}
            [[ -n $wtdir ]] && builtin cd -- "$wtdir"
            ;;
        *)
            print -u2 "wt: unknown command '$cmd' (new|rm|list)"; return 1
            ;;
    esac
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
