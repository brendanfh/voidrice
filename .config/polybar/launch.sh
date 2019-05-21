#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

FC_DEBUG=1 polybar -l info main

notify-send "Polybar launched!"
