#!/bin/sh

wal -i "$(cat ~/.background)" &
compton --config ~/.config/compton/compton.conf &
nm-applet &
"$HOME/.dwm/dunst_launch.sh" &
"$HOME/.dwm/status.sh" &
