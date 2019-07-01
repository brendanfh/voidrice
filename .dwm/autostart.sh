#!/bin/sh

wal -i "$(cat ~/.background)" &
compton --config ~/.config/compton/compton.conf &
nm-applet &
xautolock -time 10 -locker "$HOME/.scripts/tools/lock" &
"$HOME/.dwm/dunst_launch.sh" &
"$HOME/.dwm/status.sh" &
