export HOMEBREW_NO_ENV_HINTS=1
export BREW_PREFIX="$(brew --prefix)"
export BREW_ZSH_SITE="${BREW_PREFIX}/share/zsh/site-functions"

alias brewup="brew update && brew upgrade && brew autoremove && omz update"
