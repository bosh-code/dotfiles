#!/usr/bin/env bash
#
# setup-dotnet.sh - Setup dotnet
#

# mise-en-place dotnet usually doesn't "register" itself, so this does it manually.
sudo mkdir -pv /etc/dotnet
echo "/Users/Ryan.Bosher/.local/share/mise/dotnet-root" | sudo tee /etc/dotnet/install_location_arm64
