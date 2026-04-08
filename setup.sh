#!/usr/bin/env bash
#
# setup.sh - Setup script for dotfiles.
#

set -euo pipefail

echo -e "Setting up dotfiles...\n"

# This file should be in the root of the dotfiles dir
dotfiles="$(cd "$(dirname "$0")" && pwd)"
echo "Dotfiles directory: $dotfiles"

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed, skipping..."
fi

# TODO: setup brewfile - Install Homebrew packages.
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
[ -d "$HOME/.config" ] && cp "$HOME/.config" "$HOME/.config-backup" -R
link_path "$dotfiles/.config" "$HOME"

# Link local/share
[ -d "$HOME/.local/share" ] && cp "$HOME/.local/share" "$HOME/.local/share-backup" -R
link_path "$dotfiles/.local/share" "$HOME/.local/share"

# Link .ssh
[ -d "$HOME/.ssh" ] && cp "$HOME/.ssh" "$HOME/.ssh-backup" -R
link_path "$dotfiles/.ssh" "$HOME"

# Link .zshenv and .zshrc
link_file "$dotfiles/.zshenv" "$HOME/.zshenv"
link_file "$dotfiles/.zshrc" "$HOME/.zshrc"

# Make dirs for work and personal projects
mkdir -p "$HOME/Work/worktrees"
mkdir -p "$HOME/Developer/worktrees"
mkdir -p "$HOME/Sites"

echo -e "\nDotfiles setup complete, restart terminal or source ~/.zshrc\n"
