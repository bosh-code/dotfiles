#!/usr/bin/env bash
#
# op - 1Password CLI integration for Zsh
#

# Using 1Password CLI secret reference
# export MISE_GITHUB_TOKEN="op://Private/3h5xcpycxxkdtekojhbvfvqzpa/token"

source ~/.config/op/plugins.sh
# Then 1Password can auto-inject secrets referenced with op://
# eval "$(op signin)"
# Or with bitwarden:
# MISE_GITHUB_TOKEN=$(bw get password github-token)

# export MISE_GITHUB_TOKEN
