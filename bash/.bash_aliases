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

# Worktree + tmux window: agent beside vim.
# usage: wt <branch> [agent-cmd]
wt()
{
  [ -n "$TMUX" ] || { printf 'Run inside tmux\n' >&2; return 1; }

  local -r branch="$1" agent="${2:-claude}"

  [ -n "$branch" ] ||
    { printf 'usage: wt <branch> [agent-cmd]\n' >&2; return 1; }

  local gitdir toplevel wtdir

  gitdir="$(git rev-parse --path-format=absolute --git-common-dir)" || return
  readonly gitdir

  toplevel="$(dirname "$gitdir")"
  readonly toplevel

  wtdir="$toplevel/../$(basename "$toplevel")-${branch//\//-}"
  readonly wtdir

  git worktree add -b "$branch" "$wtdir" || return
  tmux new-window -n "$branch" -c "$wtdir" "$agent" \; \
    split-window -h -b -l 60% -c "$wtdir" 'vim .'
}

# Remove a worktree and its branch.
# usage: wtrm <branch>
wtrm()
{
  local -r branch="$1"

  [ -n "$branch" ] ||
    { printf 'usage: wtrm <branch>\n' >&2; return 1; }

  local gitdir toplevel wtdir

  gitdir="$(git rev-parse --path-format=absolute --git-common-dir)" || return
  readonly gitdir

  toplevel="$(dirname "$gitdir")"
  readonly toplevel

  wtdir="$toplevel/../$(basename "$toplevel")-${branch//\//-}"
  readonly wtdir

  if [ -d "$wtdir" ]; then
    git worktree remove "$wtdir" || return
  else
    printf 'Folder already gone, pruning worktree records\n' >&2
    git worktree prune
  fi

  git branch -d "$branch"
}
