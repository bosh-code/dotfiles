#!/usr/bin/env zsh
#
# fnox - fnox configuration
#

has fnox && is-enabled fnox || return

export FNOX_CONFIG_DIR="$XDG_DATA_HOME/fnox"
eval "$(fnox activate zsh)"
