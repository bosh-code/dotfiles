#
# __init__: This runs prior to any other conf.d contents.
#

# Apps
# User zed as the default editor
# https://zed.dev/docs/reference/cli#-w---wait
# Or VSCode. I keep switching...
export EDITOR="zed --wait"
# export VISUAL=code
export VISUAL=code-insiders
export PAGER=bat

# fzf
source <(fzf --zsh)

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
