#!/usr/bin/env bash
#
# container - Apple Container
#

# is-macos && has container && is-enabled container || return

# export DOCKER_HOST=unix://$HOMEBREW_PREFIX/var/run/socktainer/.socktainer/container.sock

# docker context create --description socktainer --docker "host=unix://${HOME}/.socktainer/container.sock" socktainer
# docker context use socktainer

# run socktainer
# HOME="$HOMEBREW_PREFIX/var/run/socktainer" $HOMEBREW_PREFIX/opt/socktainer/bin/socktainer

# To start socktainer now and restart at login:
#  brew services start socktainer
# Or, if you don't want/need a background service you can just run:
#  HOME="$HOMEBREW_PREFIX/var/run/socktainer" $HOMEBREW_PREFIX/opt/socktainer/bin/socktainer
