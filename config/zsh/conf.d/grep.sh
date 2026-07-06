#!/usr/bin/env bash
#
# grep - Grep aliases using ripgrep
#

has rg || return

# For bat aliases, see .config/zsh/conf.d/bat.sh
# alias rg="batgrep"
alias grep="rg"
alias egrep="rg -e"
alias fgrep="rg -F"
alias sgrep="rg --files-with-matches --no-filename -C 5"
