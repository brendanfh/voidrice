#!/bin/sh

xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0

xrandr \
	--output DP1-1 --off \
	--output DP1-2 --off \
	--output DP1-3 --off \
	--output DP2 --off \
	--output DP2-1 --off \
	--output DP2-2 --off \
	--output DP2-3 --off \
	--output HDMI1 --off \
