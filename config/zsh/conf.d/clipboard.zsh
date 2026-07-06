#!/usr/bin/env zsh
#
# clipboard - Clipboard ("pasteboard") aliases
#

# Only run on macos
is-macos || return

# copy silently
alias -g C='| pbcopy'
# copy + show output
alias -g CC='| tee >(pbcopy)'
# Examples:
# cat .env C      # copy silently
# cat .env.sample CC     # copy + show output

# Re-run the last command and copy its output.
pblast() {
  eval "$(fc -ln -1)" | pbcopy
}

# Run any command and pipe its stdout to the macOS clipboard.
# Usage: pb cat ~/.dotfiles/.zshrc
#        pb git log --oneline -20
pb() {
  if (( $# == 0 )); then
    # No args: just copy whatever's on stdin (acts like pbcopy)
    pbcopy
  else
    "$@" | pbcopy
  fi
}

# Copy to clipboard and show (print - pbPrint) output
pbp() {
  if (( $# == 0 )); then
    tee >(pbcopy)
  else
    "$@" | tee >(pbcopy)
  fi
}
