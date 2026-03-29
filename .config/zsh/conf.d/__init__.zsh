#
# __init__: This runs prior to any other conf.d contents.
#

# Apps
# User zed as the default editor
# https://zed.dev/docs/reference/cli#-w---wait
export EDITOR="zed --wait"
export VISUAL=code
export PAGER=less

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
  $HOMEBREW_PREFIX/opt/go/libexec/bin(N)
  $HOMEBREW_PREFIX/share/npm/bin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)
)
