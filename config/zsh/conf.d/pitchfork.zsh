#!/usr/bin/env zsh
#
# pitchfork - pitchfork configuration
#

if [[ -x "$(command -v pitchfork)" ]] && (( ZSH_PITCHFORK_ENABLED )); then
  export PITCHFORK_CONFIG_DIR="$XDG_DATA_HOME/pitchfork"
  eval "$(pitchfork activate zsh)"
fi
