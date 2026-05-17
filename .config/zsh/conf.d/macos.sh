#!/usr/bin/env bash
#
# macos - macOS-specific aliases
#

[[ "$OSTYPE" == darwin* ]] || return

alias battery="system_profiler SPPowerDataType | grep -A3 -B7 \"Condition\""
