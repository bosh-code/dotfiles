#!/bin/env bash
#
# op - 1Password CLI integration for shell env
#

# source ~/.config/op/plugins.sh if it exists
if [[ -f "${XDG_DATA_HOME}/op/plugins.sh" ]]; then
  source "${XDG_DATA_HOME}/op/plugins.sh"
fi

export OP_ENV="${XDG_DATA_HOME}/op/.env"

# 1password env run
alias oper="op run --env-file=\"${OP_ENV}\" --"

opwrap() {
  if [[ -z "$1" ]]; then
    echo "Usage: opwrap <command> [args...]"
    return 1
  fi

  local cmd="$1"
  shift

  echo "op run --env-file=\"${OP_ENV}\" -- $cmd $*"
  op run --env-file="${OP_ENV}" -- "$cmd" "$@"
}
