#!/bin/env zsh
#
# op-auto-run - Transparently run selected commands through 1Password.
#

# Do not install the widget in non-interactive contexts.
[[ -o interactive ]] || return 0

# Skip setup if required binaries/files are unavailable.
command -v op >/dev/null 2>&1 || return 0
[[ -n "${OP_ENV:-}" && -r "${OP_ENV}" ]] || return 0

# This module depends on zsh-hooks plugin helpers.
(( $+functions[hooks-add-hook] && $+functions[hooks-run-hook] && $+functions[hooks-define-hook] )) || return 0

op_auto_run_debug() {
  [[ "${OP_AUTO_RUN_DEBUG:-0}" == "1" ]] || return 0
  print -u2 -- "[op-auto-run] $*"
}

# Commands that should automatically inherit secrets via `oper`.

typeset -ga OP_AUTO_RUN_COMMANDS
OP_AUTO_RUN_COMMANDS=(
  npm
  npx
  pnpm
  yarn
  bun
  deno
  nypm
)

op_auto_run_accept_line_hook() {
  emulate -L zsh

  # Set OP_AUTO_RUN_DISABLE=1 to bypass wrapping for a command/session.
  if [[ "${OP_AUTO_RUN_DISABLE:-0}" == "1" ]]; then
    op_auto_run_debug "disabled for this command"
    return
  fi

  local -a words
  local word
  local i=1
  local cmd=""
  local should_wrap=0

  words=(${(z)BUFFER})
  op_auto_run_debug "buffer=${BUFFER}"

  # Skip leading variable assignments and find the actual command token.
  while (( i <= ${#words[@]} )); do
    word="${words[i]}"
    if [[ "${word}" == [A-Za-z_][A-Za-z0-9_]*=* ]]; then
      (( i++ ))
      continue
    fi
    cmd="${word}"
    break
  done

  if [[ -n "${cmd}" && "${cmd}" != "oper" && "${cmd}" != "op" ]]; then
    for word in "${OP_AUTO_RUN_COMMANDS[@]}"; do
      if [[ "${cmd}" == "${word}" ]]; then
        should_wrap=1
        break
      fi
    done
  fi

  if (( should_wrap )); then
    op_auto_run_debug "wrapping command=${cmd}"
    BUFFER="op run --env-file=\"${OP_ENV}\" -- ${BUFFER}"
  else
    op_auto_run_debug "no-wrap command=${cmd:-<none>}"
  fi
}

op_auto_run_accept_line_dispatch() {
  emulate -L zsh
  hooks-run-hook accept_line_hook
  zle .accept-line
}

hooks-define-hook accept_line_hook
zle -N accept-line op_auto_run_accept_line_dispatch
hooks-add-hook accept_line_hook op_auto_run_accept_line_hook
