#!/usr/bin/env zsh
#
# mise - mise dev tool manager aliases
#

# check for mise
printf "Checking for mise... "
if [[ -x "$(command -v mise)" ]]; then
  echo "found"
else
  echo "not found, skipping mise setup"
  return
fi
[[ -x "$(command -v mise)" ]] || return

alias mp="mise"
alias mpi="mp install"
alias mpu="mp use"
alias mpug="mpu -g"
alias mpup="mp update"

# eval "$(mise activate zsh)"
# fnox & pitchfork are installed via mise, so activate after mise.
export FNOX_CONFIG_DIR = "$XDG_DATA_HOME/fnox"
export PITCHFORK_CONFIG_DIR = "$XDG_DATA_HOME/pitchfork"
# eval "$(fnox activate zsh)"
[[ -x "$(command -v fnox)" ]] && eval "$(fnox activate zsh)"
[[ -x "$(command -v pitchfork)" ]] && eval "$(pitchfork activate zsh)"
# eval "$(pitchfork activate zsh)"
