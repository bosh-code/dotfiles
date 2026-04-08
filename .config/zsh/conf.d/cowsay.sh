#!/usr/bin/env bash
#
# cowsay - Custom cowfile configuration
#

export COWPATH="$HOME/.config/cowfiles"

alias carl="cowsay -f $COWPATH/carl.cow"

alias randomcow="cowsay -f \"$(ls $COWPATH | shuf -n1)\""
alias cowfortune="fortune | cowsay -f \"$(ls $COWPATH | shuf -n1)\""
