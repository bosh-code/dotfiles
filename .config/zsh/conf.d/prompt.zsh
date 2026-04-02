#
# prompt: Set up the Zsh prompt system.
#

# Initialize prompt
setopt prompt_subst transient_rprompt
autoload -Uz promptinit && promptinit
# prompt p10k # no custom theme rn
source $ZDOTDIR/.p10k.zsh
