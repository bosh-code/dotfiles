#!/bin/env bash
#
# op - 1Password CLI integration for shell env
#

# source ~/.config/op/plugins.sh if the file exists
if [[ -f "${XDG_DATA_HOME}/op/plugins.sh" ]]; then
  # shellcheck disable=SC1091 # file may not exist, can't load it
  source "${XDG_DATA_HOME}/op/plugins.sh"
fi

export OP_ENV="${XDG_DATA_HOME}/op/.env"

# 1password env run
# shellcheck disable=SC2139 # I want it to expand when defined
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
