#!/usr/bin/env bash
#
# setup.sh - Setup script for DOTFILES.
# TODO: Move this to script/setup.sh and make the root setup.sh call it.
# Incase whatever reads the repo runs looks for a root setup script instead of sript/setup.sh
# dont automate the linking, make that manual commands
#

set -euo pipefail

# test if we're in the right directory, should be $HOME/.dotfiles
if [[ "$(basename "$PWD")" != ".dotfiles" ]]; then
  echo "Error: Please run this script from the root of the DOTFILES directory."
  exit 1
fi

# This file must be in the root of the DOTFILES dir
DOTFILES="$(cd "$(dirname "$0")" && pwd)"
export DOTFILES

# Source vars
source "$DOTFILES/scripts/vars.sh"

# print the keys in the fileLinkMap and dirLinkMap
echo "Files to link:"
for key in "${!fileLinkMap[@]}"; do
  echo "  $key -> ${fileLinkMap[$key]}"
done

echo "Directories to link:"
for key in "${!dirLinkMap[@]}"; do
  echo "  $key -> ${dirLinkMap[$key]}"
done

# test that required commands are available
for cmd in "${required_programs[@]}"; do
  if ! command -v "$cmd" &> /dev/null; then
    echo "Error: Required command '$cmd' not found. Please install it and try again."
    exit 1
  fi
done

echo -e "Setting up DOTFILES...\n"

printf "This is potentially destructive. Files and dirs are backed up before being deleted, but there are still risks.\n"
read -rep "Continue? (y/n) " -n 1 -r
echo    # move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting setup."
    exit 1
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found, installing..."
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed, skipping..."
fi

# TODO: setup brewfile - Install Homebrew packages.
# brew bundle --file="$DOTFILES/Brewfile"

# Create backup dir
#mkdir -pv $HOME/.backups

# iterate through the dirLinkMap and backup all the target dirs, then delete them, then link the source dir to the target dir
for key in "${!dirLinkMap[@]}"; do
  target="$key"
  source="${dirLinkMap[$key]}"
  
  if [ -d "$target" ]; then
    echo "Backing up $target to $HOME/.backups/$(basename "$target")-backup"
    
    #cp -r "$target" "$HOME/.backups/$(basename "$target")-backup"
    # Have to delete before linking
    #rm -rf "$target"
  else
    echo "Directory $target does not exist, skipping backup..."
  fi
  
  echo "Linking $source to $target"
  #ln -s "$source" "$target"
done

# iterate through the fileLinkMap and backup all the target files, then delete them, then link the source file to the target file
for key in "${!fileLinkMap[@]}"; do
  target="$key"
  source="${fileLinkMap[$key]}"
  if [ -f "$target" ]; then
    echo "Backing up $target to $HOME/.backups/$(basename "$target")-backup"
    
    #cp "$target" "$HOME/.backups/$(basename "$target")-backup"
    # Have to delete before linking
    #rm -f "$target"
  else
    echo "File $target does not exist, skipping backup..."
  fi

  echo "Linking $source to $target"
  #ln -s "$source" "$target"
done


# Link NuGet config
# mkdir -p "$DOTFILES/.local/share/nuget"
# ln -s "$HOME/.local/share/nuget/NuGet.Config" "$HOME/.nuget/NuGet/NuGet.Config"

for newDir in "${newDirs[@]}"; do
  if [ ! -d "$newDir" ]; then
    echo "Creating directory $newDir"
    
    #mkdir -p "$newDir"
  else
    echo "Directory $newDir already exists, skipping..."
  fi
done
