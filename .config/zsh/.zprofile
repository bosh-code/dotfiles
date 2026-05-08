#!/usr/bin/env zsh
# echo "[debug] ~/.config/zsh/.zprofile loaded at: $(date +%T.%N) with PID $$ from $0" >&2

# TODO: what to do with .zprofile?
# .zprofile is loaded on login shells, but not interactive non-login shells.

# add "/home/linuxbrew/.linuxbrew/bin/" to path
# export PATH="/home/linuxbrew/.linuxbrew/bin/:$PATH"

# Initialize Homebrew
# if command -v brew &>/dev/null; then # we know brew is in PATH
#   eval "$(brew shellenv zsh)"
# else
#   # Brew not in path, look for it.
#   if $OS = "Linux"; then
#     if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
#       eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#     fi
#   elif $OS = "Darwin"; then
#     if [[ -f /opt/homebrew/bin/brew ]]; then
#       eval "$(/opt/homebrew/bin/brew shellenv)"
#     fi
#   fi
# fi

# macOS
# eval "$(/opt/homebrew/bin/brew shellenv)" 

# linux
# eval /home/linuxbrew/.linuxbrew/bin/brew shellenv