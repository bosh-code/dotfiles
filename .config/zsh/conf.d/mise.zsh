#!/usr/bin/env zsh
#
# mise - mise dev tool manager aliases
#

export MISE_HOME="$XDG_DATA_HOME/mise" # $HOME/.local/share/mise

alias mp="mise"
alias mpi="mp install"
alias mpu="mp use"
alias mpug="mpu -g"
alias mpup="mp update"

eval "$(mise activate zsh)"
# fnox & pitchfork are installed via mise, so activate after mise.
eval "$(fnox activate zsh)"
eval "$(pitchfork activate zsh)"
