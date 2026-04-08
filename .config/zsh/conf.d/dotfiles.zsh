#!/usr/bin/env zsh
#
# dotfiles - Dotfiles directory navigation
#

: ${DOTFILES:=$HOME/.dotfiles}
alias dotf='cd "$DOTFILES"'
alias dotfl="cd \$DOTFILES/.local"
alias zdot='cd $ZDOTDIR'
