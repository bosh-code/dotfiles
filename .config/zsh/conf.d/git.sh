#!/usr/bin/env bash
#
# git - Git and GitHub 'hub' aliases and functions
#

# git add + commit -m
gacmsg() {
  gaa && gcmsg "$1"
}

# git commit -m + push
gcmsgp() {
  gcmsg "$1" && gp
}

# git add + commit -m + push
gacmsgp() {
  gacmsg "$1" && gp
}

[[ -x "$(command -v hub)" ]] || return

# alias for hub, git with exta GH stuff
eval "$(hub alias -s)"
alias gs="hub sync"
