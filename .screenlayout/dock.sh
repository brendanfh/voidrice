#!/bin/sh

# Unused
xrandr --output DP1-3 --off --output DP2 --off --output HDMI1 --off --output VIRTUAL1 --off --output eDP1 --off

(xrandr --output DP1-1 --primary --crtc 0 --mode 1920x1080 --pos 0x0 --rotate normal) \
	|| (xrandr --output DP1-1 --crtc 1 --mode 1920x1080 --pos 0x0 --rotate normal) \
	|| (xrandr --output DP1-1 --crtc 2 --mode 1920x1080 --pos 0x0 --rotate normal)
(xrandr --output DP1-2 --crtc 0 --mode 1920x1080 --pos 0x0 --rotate normal) \
	|| (xrandr --output DP1-2 --crtc 1 --mode 1920x1080 --pos 0x0 --rotate normal) \
	|| (xrandr --output DP1-2 --crtc 2 --mode 1920x1080 --pos 0x0 --rotate normal)

# xrandr --output eDP1 --primary --mode 1920x1080 --pos 3840x0 --rotate normal

