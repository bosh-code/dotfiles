#!/usr/bin/env zsh
# echo "[debug] ~/.config/zsh/.zprofile loaded at: $(date +%T.%N) with PID $$ from $0" >&2

# Initialize Homebrew
#if command -v brew &>/dev/null; then # we know brew is installed.
  eval "$(brew shellenv zsh)"
#fi

# eval "$(/opt/homebrew/bin/brew shellenv)" 

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
if [ -f ~/.orbstack/shell/init.zsh ]; then
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
