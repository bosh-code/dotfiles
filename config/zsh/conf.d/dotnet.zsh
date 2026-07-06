#!/usr/bin/env zsh
#
# dotnet: Everything dotnet & nuget related
#

has dotnet && is-enabled dotnet || return

# Add .NET Core SDK tools
export PATH="$HOME/.dotnet/tools:$PATH"

# Set root vars so things like pwsh can find dotnet
export DOTNET_ROOT="$MISE_HOME/dotnet-root"
export DOTNET_ROOT_ARM64="$MISE_HOME/dotnet-root"

# nuget
export NUGET_PACKAGES="${NUGET_PACKAGES:-$XDG_CACHE_HOME/NuGetPackages}"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export TESTINGPLATFORM_TELEMETRY_OPTOUT=1

# zsh parameter completion for the dotnet CLI
# https://learn.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet
