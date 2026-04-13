#!/bin/env zsh
#
# op - 1Password CLI integration for Zsh
#

# source ~/.config/op/plugins.sh
source "${XDG_DATA_HOME}/op/plugins.sh"

export OP_ENV="${XDG_DATA_HOME}/op/.env"

# 1password env run
alias oper="op run --env-file=\"${OP_ENV}\" --"

# Source local 1Password-related hooks.
for _op_hook in "${ZSH_CONFIG_DIR}/hooks"/op*.zsh(N); do
	source "${_op_hook}"
done
unset _op_hook
