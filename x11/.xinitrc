#!/bin/bash

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
