#!/usr/bin/env zsh
#
# mise - mise dev tool manager aliases
#

# check for mise
[[ -x "$(command -v mise)" ]] || return

alias mp="mise"
alias mpi="mp install"
alias mpu="mp use"
alias mpug="mpu -g"
alias mpup="mp update"

# fnox & pitchfork are installed via mise, so activate after mise.
# if [[ -x "$(command -v mise)" ]]; then
#   (( ZSH_MISE_ENABLED )) && eval "$(mise activate zsh)"
# fi

if [[ -x "$(command -v fnox)" ]]; then
  (( ZSH_FNOX_ENABLED )) && eval "$(fnox activate zsh)"
fi

if [[ -x "$(command -v pitchfork)" ]]; then
  (( ZSH_PITCHFORK_ENABLED )) && eval "$(pitchfork activate zsh)"
fi

