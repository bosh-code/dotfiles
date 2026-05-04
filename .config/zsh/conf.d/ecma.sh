#!/usr/bin/env bash
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

# Deno
export DENO_DIR="$XDG_CACHE_HOME/deno"
export DENO_NO_UPDATE_CHECK=1 # mise handles updates

#
# Aliases
#

# npm
alias np="npm"
alias npi="np install"
alias npid="npi -D"
alias npig="npi -g"
alias npci="np ci"
alias npr="np run"
alias npd="npr dev"
alias npb="npr build"
alias npl="npr lint"
alias nplf="npl --fix"
alias npt="npr test"

# 1password wrapped npm
opnpm() { opwrap npm "$@"; }
alias opnpi="opnpm install"
alias opnpid="opwrap npm install -D"
alias opnpig="opwrap npm install -g"
alias opnpci="opwrap npm ci"

# yarn
alias y="yarn"
alias ya="y add"
alias yad="ya -D"
alias yi="y install"

# pnpm
alias pn="pnpm"
alias pnr="pn run"
alias pna="pn add"
alias pnad="pna -D"
alias pnag="pna -g"
alias pni="pn install"
alias pnig="pni -g"
alias pnd="pnr dev"
alias pnb="pnr build"
alias pnl="pnr lint"
alias pnlf="pnl --fix"
alias pnt="pnr test"
alias pnup="pn update"
alias pnupg="pnup -g"

# Handle pnpm versions with mise
alias pnsu="mug pnpm@latest"
