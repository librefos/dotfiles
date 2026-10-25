[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkwinsize histappend

PS1='[\u@\h \W]\$ '

set -o vi

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
