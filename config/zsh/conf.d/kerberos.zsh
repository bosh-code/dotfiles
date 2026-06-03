#!/usr/bin/env bash
#
# kerberos: Kerberos configuration for shell env
#

# first check for kinit, otherwise return early.
[[ -x "$(command -v kinit)" ]] || return

export KRB5_CONFIG="${XDG_DATA_HOME}/kerberos/krb5.conf"
