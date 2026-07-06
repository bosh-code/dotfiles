#!/usr/bin/env zsh
#
# __init__ - Runs prior to any other conf.d contents.
#

#
# Helpers
#

# export has helper.
# usage: has git node python
# usage: `has mise fnox && is-enabled fnox || return`
# usage: `has brew && is-linux || return`
has() {
  local cmd
  for cmd in "$@"; do
    command -v "$cmd" >/dev/null 2>&1 || return 1
  done
}

# is-enabled helper.
# usage: `is-enabled android && is-macos || return`
is-enabled() {
  # Uppercase the arg and build standard var name
  local var="DOTFILES_${1:u}_ENABLED"
  printf "[debug] Checking if %s is enabled by looking at %s: %s\n" "$1" "$var" "${(P)var}" >&2
  [[ -n "${(P)var}" && "${(P)var}" -ne 0 ]]
}

is-macos() {
  [[ "$OSTYPE" == darwin* ]]
}

is-linux() {
  [[ "$OSTYPE" == linux* ]] || [[ "$(uname -s)" == "Linux" ]]
}

# Apps
# User zed as the default editor
# https://zed.dev/docs/reference/cli#-w---wait
# Or VSCode. I keep switching...
# export EDITOR="zed --wait"
export EDITOR="code-insiders"
# export VISUAL=code
export VISUAL=code-insiders
export PAGER=bat

# Telemetry
# disable telemetry for all tools that support it.
export DISABLE_TELEMETRY=1
export DO_NOT_TRACK=1
export ENABLE_TELEMETRY=0
export TELEMETRY_DISABLED=true

# fzf
source <(fzf --zsh)

#
# mise
#

# These paths may conflict with mise paths, so they are added first.

# PNPM
export PNPM_HOME="$XDG_DATA_HOME/pnpm" # $HOME/.local/share/pnpm
export PATH="$PNPM_HOME/bin:$PATH"
# PNPM config.yaml is stored in: $XDG_CONFIG_HOME/pnpm/config.yaml

# NPM
export NPM_HOME="$XDG_DATA_HOME/npm" # $HOME/.local/share/npm
export PATH="$NPM_HOME/bin:$PATH"
export NPM_CONFIG_USERCONFIG="$NPM_HOME/.npmrc"
export NPM_GLOBAL_PREFIX="$NPM_HOME"

# Add GNUbin coreutils to path for better versions of ls, cat, etc.
export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"

# This needs run before any other conf.d files, as some need mise
export MISE_HOME="$XDG_DATA_HOME/mise" # $HOME/.local/share/mise
if [[ -x "$(command -v mise)" ]]; then
  (( DOTFILES_MISE_ENABLED )) && eval "$(mise activate zsh)"
fi

# Set the list of directories that cd searches.
cdpath=(
  $XDG_PROJECTS_DIR(N/)
  $XDG_WORK_DIR(N/)
  $XDG_CONFIG_HOME(N/)
  $XDG_LOCAL_DIR(N/)
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  # core
  $prepath
  $path

  # keg only brew apps
  $HOMEBREW_PREFIX/opt/curl/bin(N)
)
