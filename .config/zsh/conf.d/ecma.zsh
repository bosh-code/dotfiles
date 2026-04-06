#
# ecma: Everything bun, deno, node, js, ts related
#


# lazy alias
alias npx="pnpm dlx"

# npx skills add disable telemetry
export DISABLE_TELEMETRY=1

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
