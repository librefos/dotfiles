#!/usr/bin/env bash

# deploy.sh - Symlink dotfile into the user home directory via GNU Stow.
# Copyright (C) 2026 Thiago C Silva <librefos@hotmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

set -euo pipefail

readonly RED='\033[1;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

info()  { printf "${GREEN}[INFO]${NC} %b\n"  "$1" >&2; }
warn()  { printf "${YELLOW}[WARN]${NC} %b\n" "$1" >&2; }
error() { printf "${RED}[ERROR]${NC} %b\n"   "$1" >&2; exit 1; }

# Parse a comma-separated string of 1-based indices against a reference.
# Usage: parse_selection <choices_string> <array_name>
# Prints one selected element per line.  Caller collects into an array
# with: mapfile -t selected < <(parse_selection "$choices" dotfiles)
parse_selection()
{
  local choices="$1"
  local -n _arr="$2"
  local c

  IFS=',' read -ra tokens <<< "$choices"
  for c in "${tokens[@]}"; do
    c="${c// /}"
    # Reject anything that is not a positive integer.
    if [[ "$c" =~ ^[0-9]+$ ]] &&
       (( c > 0 && c <= ${#_arr[@]} )); then
      # Input is 1-based, array is 0-based.
      printf '%s\n' "${_arr[$((c-1))]}"
    else
      warn "Invalid selection ignored: $c"
    fi
  done
}

[[ "$EUID" -eq 0 ]] && error 'Do not run this script as root.'

command -v stow &>/dev/null || error "'stow' is not installed."

# Ensure Stow uses the correct source repository.
readonly REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TARGET_DIR="$HOME"

# nullglob: ensures 'all_dirs' is empty if no directories exist.
shopt -s nullglob
readonly all_dirs=("$REPO_DIR"/*/)
dotfiles=()
for dir in "${all_dirs[@]}"; do
  dotfiles+=("$(basename "$dir")")
done
shopt -u nullglob

[[ ${#dotfiles[@]} -eq 0 ]] && error 'No stow packages found.'

printf 'Available dotfile:\n'
for i in "${!dotfiles[@]}"; do
  printf '[%d] %s\n' "$((i+1))" "${dotfiles[i]}"
done

printf 'Enter numbers to stow (comma-separated) ' >/dev/tty
printf 'or press Enter to skip all: ' >/dev/tty
read -r choices </dev/tty
mapfile -t selected_dotfiles < <(parse_selection "$choices" dotfiles)
info "Selected for deployment: ${selected_dotfiles[*]}"

backup_conflict()
{
  local file="$1"
  # -e ensures it exists; -L ensures we catch broken symlinks too.
  [[ -e "$file" || -L "$file" ]] || return 0
  warn "Backing up: $file -> ${file}.bak"
  mv "$file" "${file}.bak"
}

# \K discards the error prefix so only the relative filepath remains.
stow_conflict_pat='(?:existing target is neither a link nor a directory: '
stow_conflict_pat+='|existing target is not owned by stow: )\K.+'
stow_flags=(--no-folding --dir="$REPO_DIR" --target="$TARGET_DIR")

for pkg in "${selected_dotfiles[@]}"; do
  [[ -d "$REPO_DIR/$pkg" ]] || {
    warn "Package '$pkg' not found. Skipping."
    continue
  }

  info "Checking for conflicts in $pkg..."
  # Simulate first to detect files or foreign symlinks that block us.
  while IFS= read -r conflict; do
    backup_conflict "$TARGET_DIR/$conflict"
  done < <(
    stow --simulate "${stow_flags[@]}" "$pkg" 2>&1 |
    grep -oP "$stow_conflict_pat" || true
  )

  info "Stowing $pkg..."
  if ! stow "${stow_flags[@]}" "$pkg"; then
    warn "Unresolved conflicts in '$pkg'. Resolve manually and re-run."
  fi
done

info 'Dotfile deployment complete.'
