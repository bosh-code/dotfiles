#!/usr/bin/env bash
#
# ecma: Everything bun, deno, node, js, ts related
#

if has node; then
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

  # yarn
  alias y="yarn"
  alias ya="y add"
  alias yad="ya -D"
  alias yi="y install"

  # pnpm
  alias pn="pnpm"
  alias pnx="pnpx"
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
  
  export NEXT_TELEMETRY_DISABLED=1
fi

if has deno; then
  export DENO_DIR="$XDG_CACHE_HOME/deno"
  export DENO_NO_UPDATE_CHECK=1 # mise handles updates
fi
