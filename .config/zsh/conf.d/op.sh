#!/bin/env bash
#
# op - 1Password CLI integration for shell env
#

# check for op
[[ -x "$(command -v op)" ]] || return

# source ~/.config/op/plugins.sh if the file exists
if [[ -f "${XDG_DATA_HOME}/op/plugins.sh" ]]; then
  # shellcheck disable=SC1091 # file may not exist, can't load it
  source "${XDG_DATA_HOME}/op/plugins.sh"
fi
