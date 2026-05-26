#!/usr/bin/env bash
#
# code - VS Code editor aliases
#

# Only run on macos
[[ "$OSTYPE" == darwin* ]] || return

alias vscode="code-insiders"
alias vscodium="codium-insiders"

alias code="vscode ."
alias codium="vscodium ."
