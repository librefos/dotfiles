#!/usr/bin/env bash

# PreToolUse hook: block destructive shell commands.
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

# Exit code 2 blocks the call; stderr is shown to Claude as the reason.
# Install: cp to ~/.claude/hooks/ && chmod +x. Needs only python3 (no jq).
cmd=$(python3 -I -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null)
if grep -Eq 'rm -rf|mkfs|dd if=|git push .*--force|git push .*-f( |$)|git reset --hard|git clean -[a-z]*f' <<<"$cmd"; then
  echo "Blocked by policy hook: $cmd" >&2
  exit 2
fi
exit 0
