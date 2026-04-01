#! /usr/bin/env zsh

alias y="yarn"
alias ya="y add"
alias yad="ya -D"
alias yi="y install"

alias pn="pnpm"
alias pnr="pn run"
alias pna="pn add"
alias pnad="pna -D"
alias pnag="pna -g"
alias pni="pn install"
alias pnig="pni -g"
alias pnd="pnr dev"
alias pnb="pnr build"
alias pnl="pnr lint"
alias pnlf="pnl --fix"
alias pnt="pnr test"
alias pnup="pn update"
alias pnupg="pnup -g"
# alias pnsu="pn self-update"

# Handle pnpm versions with mise
alias pnsu="mug pnpm@latest"

# pnpm
# export PNPM_HOME="/Users/bosh/Library/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end
