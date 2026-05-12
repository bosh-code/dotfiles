#!/usr/bin/env zsh
#
# clipboard - Clipboard integration for Zsh (cross-platform)
#

# ---------------------------------------------------------------------------
# Cross-platform pbcopy shim
#
# macOS already ships with `pbcopy`. On Linux we alias it to whatever
# clipboard tool is available, in this preference order:
#   1. wl-copy   (Wayland)
#   2. xclip     (X11)
#   3. xsel      (X11, fallback)
#   4. OSC 52    (terminal escape sequence — works over SSH!)
#
# ---------------------------------------------------------------------------
# About the OSC 52 fallback
# ---------------------------------------------------------------------------
# OSC 52 ("Operating System Command 52") is a terminal escape sequence that
# asks the *terminal emulator* itself to put data on the system clipboard.
# This means it works even over SSH, inside tmux, or in containers — anywhere
# you don't have a local clipboard daemon, as long as your terminal supports
# it and has the feature enabled.
#
# How to use it:
#   - Just use `pbcopy`, `pb`, `pbp`, `C`, or `CC` as normal. If no native
#     clipboard tool is found, the shim below will emit an OSC 52 sequence
#     and your terminal will copy the text to your local clipboard.
#
# Terminal support (may need to be enabled in settings):
#   - iTerm2:        Preferences → General → Selection → "Applications in
#                    terminal may access clipboard"
#   - Kitty:         enabled by default (`clipboard_control write-clipboard`)
#   - WezTerm:       enabled by default
#   - Alacritty:     enabled by default
#   - Ghostty:       enabled by default
#   - tmux:          add `set -g set-clipboard on` to ~/.tmux.conf
#   - GNOME Terminal / Konsole: limited or no support
#
# Caveats:
#   - There's a size limit (typically ~74KB after base64 encoding; some
#     terminals are smaller). Very large pastes may be truncated.
#   - Requires the terminal to be the one rendering — won't work if stdout
#     is redirected to a file.
# ---------------------------------------------------------------------------

# OSC 52 implementation — emits the escape sequence to the controlling tty.
_pbcopy_osc52() {
  local data
  data=$(cat | base64 | tr -d '\n')

  # Detect tmux / screen and wrap the sequence appropriately so it reaches
  # the outer terminal instead of being swallowed by the multiplexer.
  local seq
  if [[ -n "$TMUX" ]]; then
    seq="\ePtmux;\e\e]52;c;${data}\a\e\\"
  elif [[ "$TERM" == screen* ]]; then
    seq="\eP\e]52;c;${data}\a\e\\"
  else
    seq="\e]52;c;${data}\a"
  fi

  # Write to /dev/tty so it reaches the terminal even if stdout is piped.
  printf "$seq" > /dev/tty 2>/dev/null || printf "$seq"
}

if ! command -v pbcopy >/dev/null 2>&1; then
  if command -v wl-copy >/dev/null 2>&1; then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  elif command -v xclip >/dev/null 2>&1; then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif command -v xsel >/dev/null 2>&1; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  else
    # Final fallback: OSC 52 escape sequence (works over SSH).
    alias pbcopy='_pbcopy_osc52'
    # Note: OSC 52 read (paste) is widely disabled for security reasons,
    # so we don't define a pbpaste fallback here.
    pbpaste() {
      print -u2 "pbpaste: not available (OSC 52 read is disabled in most terminals)"
      return 127
    }
  fi
fi

# Clipboard ("pasteboard") aliases

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
