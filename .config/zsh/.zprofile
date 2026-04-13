#!/usr/bin/env zsh
# echo "[debug] ~/.config/zsh/.zprofile loaded at: $(date +%T.%N) with PID $$ from $0" >&2

# Initialize Homebrew
#if command -v brew &>/dev/null; then # we know brew is installed.
  eval "$(brew shellenv zsh)"
#fi

# eval "$(/opt/homebrew/bin/brew shellenv)" 
