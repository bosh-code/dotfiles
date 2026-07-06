#!/usr/bin/env bash
#
# android - Android SDK environment setup
#

is-enabled android && is-macos || return

export ANDROID_HOME="$HOME/.android"
export ANDROID_AVD_HOME="$ANDROID_HOME/avd"
export ANDROID_SDK_ROOT="$ANDROID_HOME/sdk"

export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
