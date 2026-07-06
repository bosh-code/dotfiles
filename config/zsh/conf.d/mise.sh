#!/usr/bin/env bash
#
# mise - mise dev tool manager aliases
#

has mise && is-enabled mise || return

alias mp="mise"
alias mpi="mp install"
alias mpu="mp use"
alias mpug="mpu -g"
alias mpup="mp update"
