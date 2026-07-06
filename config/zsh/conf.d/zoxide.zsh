#!/usr/bin/env zsh
#
# zoxide: Configure zoxide.
#

# has zoxide || return 1
# eval "$(zoxide init zsh)"

has zoxide || has __zoxide_z || return

# if ! (( $+commands[zoxide] )); then
#   echo "zoxide not found" >&2
#   return
# fi

# https://github.com/ajeetdsouza/zoxide
if (( $+functions[cached-eval] )); then
  cached-eval 'zoxide-init-zsh' zoxide init zsh
else
  source <(zoxide init zsh)
fi
