export EDITOR="nvim"
bindkey -v

alias vim="nvim"
alias vi="nvim"

alias l="ls -la --color=always | sort -f -k 9,9"
alias c="clear"

# Thank you BashBunni! #
# Pomodoro #
alias work="timer 25m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"
        
alias rest="timer 5m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

pomo(){
        echo "How many rounds you want to do?"
        read count;
        for i in {1..$count};
        do
                work;
                sleep 1;
                rest;
        done
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
