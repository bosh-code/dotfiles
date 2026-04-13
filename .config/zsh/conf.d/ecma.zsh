#!/usr/bin/env zsh
#
# ecma: Everything bun, deno, node, js, ts related
#

# lazy alias
alias npx="pnpm dlx"

# npx skills add disable telemetry
export DISABLE_TELEMETRY=1

# PNPM
export PNPM_HOME="$XDG_DATA_HOME/pnpm" # $HOME/.local/share/pnpm
export PATH="$PNPM_HOME:$PATH"

# NPM
export NPM_HOME="$XDG_DATA_HOME/npm" # $HOME/.local/share/npm
export PATH="$NPM_HOME/bin:$PATH"
export NPM_CONFIG_USERCONFIG="$NPM_HOME/.npmrc"
