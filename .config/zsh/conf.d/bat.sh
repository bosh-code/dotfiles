#!/usr/bin/env bash
#
# bat - bat and bat-extras configuration
#

# Batman
# https://github.com/eth-p/bat-extras/blob/master/doc/batman.md
eval "$(batman --export-env)"

# Batpipe
# https://github.com/eth-p/bat-extras/blob/master/doc/batpipe.md
eval "$(batpipe)"

alias cat="bat"
alias bgrep="batgrep"

batdiff() {
    git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff
}

alias bathelp='bat --plain --language=help'
bhelp() {
    "$@" --help 2>&1 | bathelp
}
