#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# xmodmap "clear lock"
# xmodmap "keycode 9 = Caps_Lock NoSymbol Caps_Lock"
# xmodmap "keycode 66 = Escape NoSymbol Escape"
# setxkbmap -option caps:swapescape

exec dwm
# exec berry
# exec sowm
