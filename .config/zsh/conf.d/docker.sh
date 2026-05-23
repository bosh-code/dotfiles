#!/usr/bin/env bash
#
# docker - Docker command aliases
#

[[ -x "$(command -v docker)" ]] || return

# Core
alias d="docker"

# Containers
alias dps="d ps -a"
alias drm="d rm"
alias drmf="d rm -f"
alias drun="d run --rm -it"
alias dstop="d stop"
alias dexec="d exec -it"
alias dx="dexec"
alias dl="d logs -f"        # usage: dl <container>

# Images
alias di="d images"
alias drmi="d rmi"
alias db="d build -t"       # usage: db <tag> <context>
alias dip="d image prune -f"
alias dipa="d image prune -a -f"

# Volumes
alias dv="d volume"
alias dvp="d volume prune -f"

# Networks
alias dn="d network"
alias dnp="d network prune -f"

# System
alias ds="d system"
alias dsp="ds prune -f"           # removes stopped containers, dangling images, unused networks, build cache
alias dspv="ds prune -f --volumes"  # ^ plus volumes. destructive — use with care

# Compose
alias dc="d compose"
alias dcu="dc up -d"
alias dcd="dc down"
alias dcp="dc pull"
alias dcr="dc restart"
alias dcs="dc stop"
alias dcb="dc build"
alias dcps="dc ps -a"
alias dcl="dc logs -f"
alias dcexec="dc exec"
alias dcx="dcexec"

# Compose functions

# Pull latest images, restart the stack, and prune old images.
# Usage: dcpu [project_directory]
dcpu() {
  local dir="${1:-.}"
  local cmds=(
    "docker compose -f '$dir' pull"
    "docker compose -f '$dir' down"
    "docker compose -f '$dir' up -d"
    "docker image prune -a -f"
  )
  for cmd in "${cmds[@]}"; do
    echo "→ $cmd"
    eval "$cmd" || { echo "✗ Failed: $cmd"; return 1; }
  done
}

# Tail logs for a specific service, defaulting to last 50 lines.
# Usage: dclog <service> [lines]
dclog() {
  local service="${1:?usage: dclog <service> [lines]}"
  local lines="${2:-50}"
  dc logs -f --tail="$lines" "$service"
}

# Open a shell in a running compose service.
# Usage: dcsh <service> [shell]
dcsh() {
  local service="${1:?usage: dcsh <service> [shell]}"
  local shell="${2:-sh}"
  dc exec "$service" "$shell"
}

alias dps1="d ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'"
alias dps2="d ps -a --format json | jq -r '[.Names, .Image, .Status, .Ports] | @tsv' | column -t"
