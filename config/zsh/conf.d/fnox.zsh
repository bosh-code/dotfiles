#!/usr/bin/env zsh
#
# fnox - fnox configuration
#

if [[ -x "$(command -v fnox)" ]] && (( ZSH_FNOX_ENABLED )); then
  export FNOX_CONFIG_DIR="$XDG_DATA_HOME/fnox"
  eval "$(fnox activate zsh)"
fi
