#!/usr/bin/env bash
#
# macos - macOS-specific aliases
#

is-macos || return

alias battery="system_profiler SPPowerDataType | grep -A3 -B7 \"Condition\""
