#!/usr/bin/env bash
#
# git - Git and GitHub 'hub' aliases and functions
#

has git || return

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

if has hub; then
  # alias for hub, git with exta GH stuff
  eval "$(hub alias -s)"
  alias gs="hub sync"
fi

if is-enabled gst_on_empty; then
  # Enable the 'git status on empty buffer' feature, which runs 'git status' when you hit `Enter` on an empty command line in a git repository.
  accept-line-or-gst() {
      if [[ -z $BUFFER ]]; then
          BUFFER="gst"
      fi
      zle accept-line
  }

  zle -N accept-line-or-gst
  bindkey '^M' accept-line-or-gst   # Enter key
fi
