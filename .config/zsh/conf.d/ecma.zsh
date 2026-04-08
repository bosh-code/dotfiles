#
# ecma: Everything bun, deno, node, js, ts related
#

# lazy alias
alias npx="pnpm dlx"

# npx skills add disable telemetry
export DISABLE_TELEMETRY=1

# PNPM
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# NPM
export NPM_CONFIG_USERCONFIG="$HOME/.local/share/npm/.npmrc"
