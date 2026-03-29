#!/usr/bin/env zsh

# Initialize Homebrew
if command -v brew &>/dev/null; then
  eval "$(brew shellenv zsh)"
fi

# eval "$(/opt/homebrew/bin/brew shellenv)" 

# alias for hub, git with exta GH stuff
eval "$(hub alias -s)"
alias gs="hub sync"

# Added by Toolbox App
export PATH="$PATH:/Users/Ryan.Bosher/Library/Application Support/JetBrains/Toolbox/scripts"

