#!/usr/bin/env bash
#
# fuck - thefuck - https://github.com/nvbn/thefuck
#

[[ -x "$(command -v fuck)" ]] || return

eval "$(thefuck --alias)"
# eval "$(thefuck --alias --enable-experimental-instant-mode)"

alias fu=fuck
