#!/usr/bin/env bash
#
# bat - bat and bat-extras configuration
#

# first check for bat, otherwise return early.
has bat || return

# Batman
# https://github.com/eth-p/bat-extras/blob/master/doc/batman.md
eval "$(batman --export-env)"

# Batpipe
# https://github.com/eth-p/bat-extras/blob/master/doc/batpipe.md
eval "$(batpipe)"

alias cat="bat"
alias bgrep="batgrep"
alias pbat="prettybat"
alias batw="batwatch"
alias bwatch="batw"

# /Users/bosh/.config/bat
BAT_CONFIG_DIR=$(bat --config-dir)

# BAT_CONFIG_PATH may already be set by the environment, but if not, default it to BAT_CONFIG_DIR
# homebrew reads this if using bat
export BAT_CONFIG_PATH="${BAT_CONFIG_PATH:-$BAT_CONFIG_DIR}"
export BAT_THEME="${BAT_THEME:-Catppuccin Mocha}"

# bat-extras
export BATDIFF_USE_DELTA=true

# batdiff override if bat-extras is installed:
batdiff() {
    git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff
}

alias bathelp='bat --plain --language=help'
bhelp() {
    "$@" --help 2>&1 | bathelp
}
