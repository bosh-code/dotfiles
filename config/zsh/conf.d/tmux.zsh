#!/usr/bin/env zsh
#
# tmux - tmux configuration and aliases
#

has tmux && export TMUX_CONFIG="${TMUX_CONFIG:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
has tmux && alias tmux="${aliases[tmux]:-tmux} -f \"\$TMUX_CONFIG\""
