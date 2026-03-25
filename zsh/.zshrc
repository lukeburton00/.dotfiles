eval "$(~/.local/bin/mise activate zsh)"

for f in ~/.config/zsh/*.zsh(N); do source "$f"; done
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
