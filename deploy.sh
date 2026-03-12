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

# Parse a comma-separated string of names against a reference array.
parse_selection()
{
  local choices_string="$1"
  local -n reference_array="$2"
  local choice_token

  IFS=',' read -ra tokens <<< "$choices_string"
  for choice_token in "${tokens[@]}"; do
    choice_token="${choice_token// /}"

    local is_valid_choice=false
    local valid_item
    for valid_item in "${reference_array[@]}"; do
      if [[ "$choice_token" == "$valid_item" ]]; then
        is_valid_choice=true
        break
      fi
    done

    if $is_valid_choice; then
      printf '%s\n' "$choice_token"
    else
      warn "Invalid selection ignored: $choice_token"
    fi
  done
}

[[ "$EUID" -eq 0 ]] && error 'Do not run this script as root.'

command -v stow &>/dev/null || error "'stow' is not installed."

readonly REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TARGET_DIR="$HOME"

shopt -s nullglob
readonly all_dirs=("$REPO_DIR"/*/)
dotfiles=()
for dir in "${all_dirs[@]}"; do
  dotfiles+=("$(basename "$dir")")
done
shopt -u nullglob

[[ ${#dotfiles[@]} -eq 0 ]] && error 'No stow packages found.'

# Subshell is used to isolate IFS changes when generating the list.
readonly comma_separated_list="$(IFS=','; printf '%s' "${dotfiles[*]}")"

if [[ "${1:-}" == "--list" ]]; then
  printf '%s\n' "$comma_separated_list"
  exit 0
fi

if [[ $# -eq 1 ]]; then
  choices="$1"
  info "Using provided selection: $choices"
else
  printf 'Available dotfile packages: %s\n' "$comma_separated_list"
  printf 'Enter names to stow (comma-separated) ' >/dev/tty
  printf 'or press Enter to skip all: ' >/dev/tty
  read -r choices </dev/tty
fi

mapfile -t selected_dotfiles < <(parse_selection "$choices" dotfiles)
if [[ ${#selected_dotfiles[@]} -eq 0 ]]; then
  info 'No packages selected. Exiting.'
  exit 0
fi

info "Selected for deployment: ${selected_dotfiles[*]}"

backup_conflict()
{
  local file="$1"
  [[ -e "$file" || -L "$file" ]] || return 0
  warn "Backing up: $file -> ${file}.bak"
  mv "$file" "${file}.bak"
}

stow_conflict_pat='(?:existing target is neither a link nor a directory: '
stow_conflict_pat+='|existing target is not owned by stow: )\K.+'
stow_flags=(--no-folding --dir="$REPO_DIR" --target="$TARGET_DIR")

for pkg in "${selected_dotfiles[@]}"; do
  [[ -d "$REPO_DIR/$pkg" ]] || {
    warn "Package '$pkg' not found. Skipping."
    continue
  }

  info "Checking for conflicts in $pkg..."
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
