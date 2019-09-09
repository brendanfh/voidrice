#!/bin/sh

# wal -i "$(cat ~/.background)" &
feh --bg-max "$HOME/Dropbox/Pictures/background/background.jpg"
wal -f base16-seti
# compton --config ~/.config/compton/compton.conf &
nm-applet &
# xautolock -time 10 -locker "$HOME/.scripts/tools/lock" &
"$HOME/.dwm/dunst_launch.sh" &
"$HOME/.dwm/status.sh" &
