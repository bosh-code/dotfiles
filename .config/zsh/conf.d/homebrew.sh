#!/usr/bin/env bash
#
# homebrew - Homebrew environment and aliases
#

export HOMEBREW_NO_ENV_HINTS=1
# Add BREW_PREFIX in addition to HOMEBREW_PREFIX for some old aliases/functions that may expect it.
export BREW_PREFIX="$(brew --prefix)"
export BREW_ZSH_SITE="${HOMEBREW_PREFIX}/share/zsh/site-functions"

# Add GNUbin coreutils to path for better versions of ls, cat, etc.
export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"

alias brewup="brew update && brew upgrade && brew cleanup && brew autoremove"
 