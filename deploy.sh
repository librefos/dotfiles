#!/usr/bin/env bash

# deploy.sh - Symlink dotfile into the user home directory via GNU Stow.
# Copyright (C) 2026 Thiago C. Silva <librefos@newliber.com>
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

# Color codes are computed once, and only when stderr is a terminal that
# supports them. `|| true` guards keep `set -e` from silently killing the
# script when TERM is dumb/unset (ssh -T, cron, systemd, piped output).
if [[ -t 2 ]] && command -v tput >/dev/null; then
  RED=$(tput setaf 1 2>/dev/null || true)
  GREEN=$(tput setaf 2 2>/dev/null || true)
  YELLOW=$(tput setaf 3 2>/dev/null || true)
  NC=$(tput sgr0 2>/dev/null || true) # reset to default rendition
else
  RED='' GREEN='' YELLOW='' NC=''
fi
readonly RED GREEN YELLOW NC

info()
{
  local red="$RED" green="$GREEN" yellow="$YELLOW" nc="$NC"
  local status="$1" message="$2"

  case $status in
    -w)
      printf '%b[WARN]%b %b\n' "$yellow" "$nc" "$message" >&2
      ;;
    -e)
      printf '%b[ERROR]%b %b\n' "$red" "$nc" "$message" >&2
      exit 1
      ;;
    -s)
      printf '\n%b==>%b %b\n' "$green" "$nc" "$message" >&2
      ;;
    *)
      printf '%b[INFO]%b %b\n' "$green" "$nc" "$message" >&2
      ;;
  esac
}

[[ "$EUID" -eq 0 ]] && info -e 'Do not run this script as root.'

#--- Helper Functions ---------------------------------------------------------

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
      info -w "Invalid selection ignored: $choice_token"
    fi
  done
}

backup_conflict()
{
  local file="$1"
  [[ -e "$file" || -L "$file" ]] || return 0
  info -w "Backing up: $file -> ${file}.bak"
  # --backup=numbered: never clobber an earlier .bak on re-runs
  mv --backup=numbered "$file" "${file}.bak"
}

#--------------------------------------------------------- Helper Functions ---
#--- Environment & Pre-requisites ---------------------------------------------

info -s 'Environment & Pre-requisites'

command -v stow > /dev/null 2>&1 || info -e "'stow' is not installed."

readonly REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)"
readonly TARGET_DIR="$HOME"

shopt -s nullglob
readonly all_dirs=("$REPO_DIR"/*/)
dotfiles=()
for dir in "${all_dirs[@]}"; do
  pkg_name="$(basename "$dir")"
  [[ "$pkg_name" == "firefox-policy" ]] && continue
  dotfiles+=("$pkg_name")
done
shopt -u nullglob

[[ ${#dotfiles[@]} -eq 0 ]] && info -e 'No stow packages found.'

# Subshell is used to isolate IFS changes when generating the list.
readonly comma_separated_list="$(IFS=','; printf '%s' "${dotfiles[*]}")"

#--------------------------------------------- Environment & Pre-requisites ---
#--- Package Selection --------------------------------------------------------

info -s 'Package Selection'

if [[ "${1:-}" == "--list" ]]; then
  printf '%s\n' "$comma_separated_list"
  exit 0
fi

if [[ $# -eq 1 ]]; then
  choices="$1"
  info -- "Using provided selection: $choices"
else
  printf 'Available dotfile packages: %s\n' "$comma_separated_list"
  printf 'Enter names to stow (comma-separated, or "all") ' >/dev/tty
  printf 'or press Enter to skip all: ' >/dev/tty
  read -r choices </dev/tty
fi

# Intercept "all" and expand it
if [[ "${choices,,}" == 'all' ]]; then
  choices="$comma_separated_list"
  info -- "Expanded 'all' to: $choices"
fi

mapfile -t selected_dotfiles < <(parse_selection "$choices" dotfiles)
if [[ ${#selected_dotfiles[@]} -eq 0 ]]; then
  info -- 'No packages selected. Exiting.'
  exit 0
fi

info -- "Selected for deployment: ${selected_dotfiles[*]}"

#-------------------------------------------------------- Package Selection ---
#--- Deployment & Conflict Resolution -----------------------------------------

info -s 'Deployment & Conflict Resolution'

# Conflict-path extraction, covering stow's wording across versions/types:
#   2.4.x plain file : "cannot stow ... over existing target X since neither ..."
#   2.4.x foreign link: "existing target is not owned by stow: X"
#   2.3.x plain file : "existing target is neither a link nor a directory: X"
# Single PCRE with alternation: grep -P rejects multiple -e patterns.
stow_conflict_pat='over existing target \K\S+(?= since)|existing target is not owned by stow: \K.+$|existing target is neither a link nor a directory: \K.+$'
stow_flags=(--no-folding --dir="$REPO_DIR" --target="$TARGET_DIR")

for pkg in "${selected_dotfiles[@]}"; do
  [[ -d "$REPO_DIR/$pkg" ]] || {
    info -w "Package '$pkg' not found. Skipping."
    continue
  }

  case "$pkg" in
    firefox)
      info -- "Creating Firefox base directories..."
      mkdir --parents "${TARGET_DIR}/.mozilla/firefox/main.profile/chrome"
      mkdir --parents "${TARGET_DIR}/.mozilla/firefox/developer-edition.profile/chrome"
      info -- "Installing Firefox system policies..."
      command -v sudo > /dev/null 2>&1 || info -e "'sudo' is not installed."
      sudo install -Dm0644 \
        "${REPO_DIR}/firefox-policy/etc/firefox/policies/policies.json" \
        "/etc/firefox/policies/policies.json"
      ;;
    nix)
      info -- "Creating Nix base directories..."
      mkdir --parents "${TARGET_DIR}/.config/nix/"
      ;;
    pipewire)
      info -- "Creating PipeWire base directory..."
      mkdir --parents "${TARGET_DIR}/.config/pipewire/pipewire.conf.d"
      ;;
    vim)
      info -- "Creating Vim base directories..."
      mkdir --parents "${TARGET_DIR}/.vim/undodir"
      ;;
  esac

  info -- "Checking for conflicts in $pkg..."
  while IFS= read -r conflict; do
    backup_conflict "$TARGET_DIR/$conflict"
  done < <(
    stow --simulate "${stow_flags[@]}" "$pkg" 2>&1 |
    grep --only-matching --perl-regexp "$stow_conflict_pat" || true
  )

  info -- "Stowing $pkg..."
  if ! stow "${stow_flags[@]}" "$pkg"; then
    info -w "Unresolved conflicts in '$pkg'. Resolve manually and re-run."
  fi
done

info -s 'Dotfile deployment complete.'

#----------------------------------------- Deployment & Conflict Resolution ---
