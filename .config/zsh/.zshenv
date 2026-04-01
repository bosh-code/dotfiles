#!/usr/bin/env zsh
#
# .zshenv: Zsh environment file, loaded always.
#

export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_LOCAL_DIR=${XDG_LOCAL_DIR:-$HOME/.local}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$XDG_LOCAL_DIR/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$XDG_LOCAL_DIR/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
export XDG_PROJECTS_HOME=${XDG_PROJECTS_HOME:-$HOME/Developer}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Developer}
export XDG_WORK_DIR=${XDG_WORK_DIR:-$HOME/Work}

# ZSH
export ZSH_CONFIG_DIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
export ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
export ZSH_COMPLETIONS_DIR="${ZSH_COMPLETIONS_DIR:-$ZSH_CONFIG_DIR/completions}"

# Fish-like dirs
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_user_data_dir:=${ZSH_DATA_DIR:-$HOME/.local/share}/zsh}
: ${__zsh_cache_dir:=${ZSH_CACHE_DIR:-$HOME/.cache}/zsh}
: ${__zsh_completions_dir:=${ZSH_COMPLETIONS_DIR:-$ZSH_CONFIG_DIR/completions}}

# Ensure Zsh directories exist.
() {
  local zdir
  for zdir in $@; do
    [[ -d "${(P)zdir}" ]] || mkdir -p -- "${(P)zdir}"
  done
} __zsh_{config,user_data,cache,completions}_dir XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_{RUNTIME,PROJECTS}_DIR
