eval "$(~/.local/bin/mise activate zsh)"

export EDITOR="nvim"
bindkey -v

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

alias l="ls -la --color=always | sort -f -k 9,9"
alias c="clear"

gitmux() {
    local SEARCH_DIRS=(~/dev ~)
    local FOLDER SESSION COLLISION_COUNT

    # Find git dirs and send path + basename to fzf
    FOLDER=$(fd -I -H --type d . "${SEARCH_DIRS[@]}" -d 1 \
        | while IFS= read -r dir; do
            [ -d "$dir/.git" ] && printf "%s\t%s\n" "$dir" "$(basename "$dir")"
        done \
        | fzf --with-nth=2 \
            --delimiter='\t' \
            --preview='dir=$(cut -f1 <<< {}); ls --color=always "$dir"' \
        | cut -f1) || return

    SESSION=$(basename "$FOLDER" | sed 's/[^a-zA-Z0-9]/_/g')

    if tmux has-session -t "$SESSION" 2>/dev/null; then
        [ -z "$TMUX" ] && tmux attach -t "$SESSION" || tmux switch-client -t "$SESSION"
        return
    fi

    [ -z "$TMUX" ] \
        && tmux new-session -s "$SESSION" -c "$FOLDER" \
    || { tmux new-session -ds "$SESSION" -c "$FOLDER"; tmux switch-client -t "$SESSION"; }
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

export PODMAN_COMPOSE_PROVIDER=podman

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
