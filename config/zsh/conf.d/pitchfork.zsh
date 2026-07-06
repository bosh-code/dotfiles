#!/usr/bin/env zsh
#
# pitchfork - pitchfork configuration
#

has pitchfork && is-enabled pitchfork || return

if [[ -x "$(command -v pitchfork)" ]] && (( DOTFILES_PITCHFORK_ENABLED )); then
  export PITCHFORK_CONFIG_DIR="$XDG_DATA_HOME/pitchfork"
  eval "$(pitchfork activate zsh)"
fi
