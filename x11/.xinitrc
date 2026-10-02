#!/bin/bash

# ~/.xinitrc - Executed by startx to start an X session.
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

# Source system-wide xinitrc scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Keyboard layout is configured system-wide, per hardware profile, via
# /etc/X11/xorg.conf.d/00-keyboard.conf (br on the Intel laptop, us/intl on
# the AMD desktop), so it is intentionally not set here.

exec dwm
