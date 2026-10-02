# ~/.bash_aliases - Custom aliases
# Copyright (C) 2026 Thiago C. Silva
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

alias ls='ls --classify --color=never'
alias grep='grep --color=auto'
alias runlabel='podman container runlabel run'

ssha()
{
  local key="${1:-$HOME/.ssh/id_ed25519}"
  [ -f "$key" ] || { printf 'ssha: key not found: %s\n' "$key" >&2; return 1; }

  # ssh-add -l exits 2 when it cannot reach any agent; only then start one.
  ssh-add -l >/dev/null 2>&1
  if [ "$?" -eq 2 ]; then
    eval "$(ssh-agent -s)"
  fi
  ssh-add "$key"
}
