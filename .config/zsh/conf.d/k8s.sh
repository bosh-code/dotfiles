#!/usr/bin/env bash
#
# k8s: Kubernetes
#

# first check for kubectl, otherwise return early.
[[ -x "$(command -v kubectl)" ]] || return

alias k='kubectl'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kga='kubectl get all'
alias kdp='kubectl describe pods'
alias kdd='kubectl describe deployments'
alias kds='kubectl describe services'
alias kdn='kubectl describe nodes'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kx='kubectl exec -it'
