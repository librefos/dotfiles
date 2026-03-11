# ~/.bashrc - Executed by interactive non-login shells.
# Copyright (C) 2026 Thiago C Silva
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkwinsize histappend

alias ls='ls --classify --color=never'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

export EDITOR='/usr/bin/vim'
export VISUAL="$EDITOR"
export PATH="$HOME/.local/bin:$PATH"

set -o vi
