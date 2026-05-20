#!/usr/bin/env bash
#
# docker - Docker command aliases
#

[[ -x "$(command -v docker)" ]] || return

# Docker aliases
alias d="docker"

# alias dps="d ps"
# alias dpsa="d ps -a"
alias dps="d ps -a"
alias drm="d rm"
alias drmf="d rm -f"

alias di="d images"
alias dip="d image prune -f"
alias dipa="d image prune -a -f"
alias drmi="d rmi"

alias drun="d run --rm -it"
alias dstop="d stop"

alias dexec="d exec -it"
alias dx="dexec"
# needs a container arg
alias dl="d logs -f"
# needs a tag arg
alias db="d build -t"

alias ds="d system"
# be really careful with these. `docker system prune -f` nukes stopped containers, dangling images, unused networks, and build cache in one shot.
alias dsp="ds prune -f"
alias dspv="ds prune -f --volumes"

alias dv="d volume"
alias dvp="d volume prune -f"

alias dn="d network"
alias dnp="d network prune -f"

# Docker Compose aliases
alias dc="d compose"
alias dcu="dc up -d"
alias dcd="dc down"
alias dcp="dc pull"
alias dcr="dc restart"
alias dcl="dc logs -f"
alias dcexec="dc exec"
alias dcx="dcexec"
alias dcb="dc build"
# alias dcps="dc ps"
# alias dcpsa="dc ps -a"
alias dcps="dc ps -a"
alias dcs="dc stop"

# Docker Compose helper function to pull, stop, and restart containers, then prune images
# basically a nicer way restart the stack with a new image and clean up the old one.
# Usage: dcpu [project_directory] (defaults to current directory)

dcpu() {
  local cmds=(
    "dc pull"
    "dc down"
    "dc up -d"
    "docker image prune -a -f"
  )
  for cmd in "${cmds[@]}"; do
    echo "→ $cmd"
    eval "$cmd" || { echo "✗ Failed: $cmd"; return 1; }
  done
}
