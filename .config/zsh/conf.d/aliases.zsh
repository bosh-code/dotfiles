#
# aliases
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

# more ways to ls
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ls="eza --group-directories-first"
alias l=ls
alias la="ls -lAh"
alias lsa=lsa
alias lsi="la --icons"
alias ll="lsi --git"
alias llt="lsi --tree --git-ignore"
alias ldot='ls -ld .*'

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
