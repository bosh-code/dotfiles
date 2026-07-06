#!/usr/bin/env zsh
#
# homebrew - Homebrew environment and aliases
#

has brew && is-enabled homebrew || return

# Brew environment variables are stored in .config/homebrew/brew.env
# export HOMEBREW_NO_ENV_HINTS=1
# export HOMEBREW_REQUIRE_TAP_TRUST=1
export HOMEBREW_NO_ANALYTICS=1

# Add BREW_PREFIX in addition to HOMEBREW_PREFIX for some old aliases/functions that may expect it.
export BREW_PREFIX="$(brew --prefix)"
export BREW_ZSH_SITE="${HOMEBREW_PREFIX}/share/zsh/site-functions"

# Add GNUbin coreutils to path for better versions of ls, cat, etc.
#export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"

alias brewup="brew update && brew upgrade && brew cleanup && brew autoremove"

# Source local homebrew-related hooks.
for _brew_hook in "${ZSH_CONFIG_DIR}/hooks"/brew*.zsh(N); do
	source "${_brew_hook}"
done
unset _brew_hook

# Aliases
# See also: ../functions/brew

alias br="brew"
alias bri="br install"
alias brg="bri --global"
alias bru="br update"
alias brs="br search"
alias brl="br list"
