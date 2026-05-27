#!/usr/bin/env bash
#
# direnv - direnv configuration
#

[[ -x "$(command -v direnv)" ]] || return

export DIRENV_LOG_FORMAT=""

eval "$(direnv hook zsh)"
