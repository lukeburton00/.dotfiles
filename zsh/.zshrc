export EDITOR="nvim"
bindkey -v

alias vim="nvim"
alias vi="nvim"

alias l="ls -la --color=always | sort -f -k 9,9"
alias c="clear"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export PODMAN_COMPOSE_PROVIDER=podman

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
