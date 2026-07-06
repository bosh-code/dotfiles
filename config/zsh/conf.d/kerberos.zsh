#!/usr/bin/env bash
#
# kerberos: Kerberos configuration for shell env
#

has kinit || return

export KRB5_CONFIG="${XDG_DATA_HOME}/kerberos/krb5.conf"
