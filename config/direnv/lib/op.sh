#!/usr/bin/env bash
#
# op - 1Password CLI integration for direnv
#

use_op() {
  local env_file="${1:-.env}"
  if ! has op; then
    log_error "op: 1Password CLI not found"
    return 1
  fi
  if [[ ! -f "$env_file" ]]; then
    log_error "op: $env_file not found"
    return 1
  fi
  watch_file "$env_file"
  # op inject reads the file, resolves op:// refs, and outputs KEY=value lines
  while IFS='=' read -r key value; do
    [[ -z "$key" || "$key" == \#* ]] && continue
    export "$key=$value"
  done < <(op inject --in-file "$env_file")
}
