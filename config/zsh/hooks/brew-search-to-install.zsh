#!/bin/env zsh
#
# brew-search-to-install.zsh - If the last command was `brew search <term>`, fill the prompt with `brew install <term>` when alt+b is pressed.
#


# Bind alt+b to: if last command was `brew search <term>`, fill prompt with `brew install <term>`
_brew_search_to_install() {
  local last_cmd="$(fc -ln -1)"
  printf "Last command: %s\n" "$last_cmd" >&2
  
  if [[ "$last_cmd" =~ ^brew[[:space:]]+search[[:space:]]+(.+)$ ]]; then
    local term="${match[1]}"
    BUFFER="brew install ${term}"
    CURSOR=${#BUFFER}
  else 
    printf "Last command was not a brew search.\n" >&2
    return 0;
  fi
}

zle -N _brew_search_to_install
bindkey '\C-b' _brew_search_to_install
