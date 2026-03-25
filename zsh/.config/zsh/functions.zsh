gitmux() {
    local sessions
    sessions=${(j:|:)${(f)"$(tmux list-sessions -F '#{session_name}' 2>/dev/null)"}}

    local selection
    selection=$(fd -I -H --type d '^\.git$' ~/dev ~ -d 2 2>/dev/null \
        | awk -v s="$sessions" '
            BEGIN { n=split(s,a,"|"); for(i=1;i<=n;i++) active[a[i]]=1 }
            {
                dir=$0; sub(/\/\.git\/$/, "", dir)
                n=split(dir,p,"/"); base=p[n]
                branch="detached"
                headfile=dir"/.git/HEAD"
                if ((getline line < headfile) > 0)
                    if (sub(/^ref: refs\/heads\//, "", line)) branch=line
                close(headfile)
                sname=base; gsub(/[^a-zA-Z0-9]/, "_", sname)
                act=(sname in active)
                printf "%s\t%s\t%s (%s)%s\n", (act?"0":"1"), dir, base, branch, (act?" ★":"")
            }' \
        | sort -t$'\t' -k1,1 | cut -f2- \
        | fzf --multi --with-nth=2 --delimiter='\t' --query="$*" \
            --header="enter: open workspace · C-x: kill · C-n: detached · C-r: refresh" \
            --expect=ctrl-x,ctrl-n,ctrl-r \
            --preview='git -C {1} log --oneline -8 2>/dev/null; echo; git -C {1} status --short 2>/dev/null' \
            --preview-window="right:50%") || return

    local lines=("${(@f)selection}")
    local key=$lines[1]
    local items=("${(@)lines[2,-1]}")
    local folder=${items[1]%%$'\t'*}

    case "$key" in
        ctrl-x|ctrl-n)
            local f s
            for item in "${items[@]}"; do
                f=${item%%$'\t'*}
                s=${f:t}
                s=${s//[^a-zA-Z0-9]/_}
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
            local session=${folder:t}
            session=${session//[^a-zA-Z0-9]/_}
            if ! tmux has-session -t "$session" 2>/dev/null; then
                tmux new-session -ds "$session" -c "$folder"
            fi
            if [[ -z $TMUX ]]; then
                tmux attach -t "$session"
            else
                tmux switch-client -t "$session"
            fi ;;
    esac
}

bindkey -s '^f' 'gitmux\n'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
