#!/usr/bin/env bash
#
# setup.sh - Setup script for dotfiles.
#

set -euo pipefail

# This file should be in the root of the dotfiles dir
dotfiles="$(cd "$(dirname "$0")" && pwd)"
echo "Dotfiles directory: $dotfiles"

config="$HOME/.config"
local="$HOME/.local"

# Install Homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew packages.
# brew bundle --file="$dotfiles/Brewfile"

# Create symlinks
link_path() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"

  # unlink "$dst" || true
  echo "Linking $src to $dst"
  ln -s "$src" "$dst"
}

link_file() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"

  # unlink "$dst" || true
  echo "Linking $src to $dst"
  ln -s "$src" "$dst"
}

# Link config
# rm -rf "$config"
# link_path "$dotfiles/.config" "$HOME"

# Link local/share
# rm -rf "$local/share"
# link_path "$dotfiles/.local/share" "$local/share"

link_file "$dotfiles/.zprofile" "$HOME/.zprofile"
# link_file "$dotfiles/.zshenv" "$HOME/.zshenv"
# link_file "$dotfiles/.zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/Developer/work/worktrees"
mkdir -p "$HOME/Developer/personal/worktrees"
mkdir -p "$HOME/Developer/other/worktrees"
mkdir -p "$HOME/Sites"

echo "Dotfiles setup complete, restart terminal"
