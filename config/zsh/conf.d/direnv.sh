#!/usr/bin/env bash
#
# direnv - direnv configuration
#

has direnv || return

export DIRENV_LOG_FORMAT=""
export DIRENV_WARN_TIMEOUT=0

eval "$(direnv hook zsh)"
