#!/usr/bin/env bash
#
# vars.sh - All the vars for the setup script.
#

# The programs needed to run the setup script.
required_programs=(
  "ln"
  "cp"
  "mkdir"
  "zsh"
  "git"
)

# The programs that are isntalled by the setup script, but are not required to run it.
optional_programs=(
  "mise"
)

# The files list that we want to backup and link.
files=(
  "$HOME/.zshenv"
  "$HOME/.zshrc"
)

# The directories list that we want to backup and link.
dirs=(
  "$HOME/.config"
  "$HOME/.local/share"
  "$HOME/.ssh"
)

# The directories list that we want to create.
newDirs=(
  "$HOME/Work/worktrees"
  "$HOME/Developer/worktrees"
  "$HOME/Sites"
)

# When we link we need the source and target. Store them in a map.
# The key is the target (the file that will be linked to) and the value is the source (the file that will be linked from).

# files to link, with source and target
declare -A fileLinkMap=(
    ["$HOME/.zshenv"]="$DOTFILES/.zshenv"
    ["$HOME/.zshrc"]="$DOTFILES/.zshrc"
)

# dirs to link, with source and target
declare -A dirLinkMap=(
  ["$HOME/.config"]="$DOTFILES/config"
  ["$HOME/.local/share"]="$DOTFILES/local/share"
  ["$HOME/.ssh"]="$DOTFILES/.ssh"
)
