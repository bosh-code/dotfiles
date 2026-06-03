#!/usr/bin/env zsh
#
# __init__ - Runs prior to any other conf.d contents.
#

# Apps
# User zed as the default editor
# https://zed.dev/docs/reference/cli#-w---wait
# Or VSCode. I keep switching...
# export EDITOR="zed --wait"
export EDITOR="code-insiders"
# export VISUAL=code
export VISUAL=code-insiders
export PAGER=bat

# fzf
source <(fzf --zsh)

#
# mise
#

# These paths may conflict with mise paths, so they are added first.

# PNPM
export PNPM_HOME="$XDG_DATA_HOME/pnpm" # $HOME/.local/share/pnpm
export PATH="$PNPM_HOME/bin:$PATH"

# NPM
export NPM_HOME="$XDG_DATA_HOME/npm" # $HOME/.local/share/npm
export PATH="$NPM_HOME/bin:$PATH"
export NPM_CONFIG_USERCONFIG="$NPM_HOME/.npmrc"

# Add GNUbin coreutils to path for better versions of ls, cat, etc.
export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"

# This needs run before any other conf.d files, as some need mise
export MISE_HOME="$XDG_DATA_HOME/mise" # $HOME/.local/share/mise
if [[ -x "$(command -v mise)" ]]; then
  (( ZSH_MISE_ENABLED )) && eval "$(mise activate zsh)"
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
