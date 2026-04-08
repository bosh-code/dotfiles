#!/usr/bin/env bash
#
# aliases - Common shell aliases
#

# References
# - https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# - https://github.com/webpro/dotfiles/blob/master/system/.alias
# - https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
#

# single character shortcuts - be sparing!
alias git="hub" # use hub as its better
alias g="git" # shorthand
alias gs="g sync" # fetch and pull

# mask built-ins with better defaults
alias ping='ping -c 5'
alias grep="rg --exclude-dir={.git,.vscode}"

alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# more ways to ls
alias l="eza --group-directories-first --icons"
alias ls="l"
alias la="l -lAh"
alias lsa=la
alias ll="la --git"
alias llt="la --tree --git-ignore"
alias ldot='l -ld .*'

# fix typos
alias get=git
alias quit=exit
alias cd..='cd ..'
alias zz=exit

# disk usage
alias du='dust'
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# misc
alias _="sudo "
alias please=sudo
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias clear="clear && printf '\e[3J'"
alias cls='clear'
alias c='cls'
alias ezec="exec zsh"
alias zource="source ~/.zshrc"
