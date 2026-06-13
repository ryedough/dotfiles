#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

set -o vi

export GOPATH=$HOME/.local/share/go
export PATH="$PATH:$HOME/.config/scripts/executable"

source $HOME/.config/scripts/bashrc/acd_func.sh

eval "$(starship init bash)"


