#!/usr/bin/env zsh
#
# terminal - Terminal-specific shell integration
#

case "${TERM_PROGRAM:l}" in
  apple_terminal)
    export SHELL_SESSIONS_DISABLE=1
    ;;
  ghostty)
    source ${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration
    ;;
  wezterm)
    source "$ZDOTDIR/lib/wezterm-shell-integration.sh"
    function set_current_shell() {
      __wezterm_set_user_var "TERM_CURRENT_SHELL" "zsh ${${ZSH_PATCHLEVEL:-$ZSH_VERSION}#zsh-}"
    }
    set_current_shell
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd set_current_shell
    ;;
esac
