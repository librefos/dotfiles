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
