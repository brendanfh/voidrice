#!/usr/bin/env bash

source "${HOME}/.cache/wal/colors.sh"

/usr/local/bin/dunst \
    -lb "${color2:-#F0F0F0}" \
    -nb "${color2:-#F0F0F0}" \
    -cb "${color2:-#F0F0F0}" \
    -lf "${color7:=#000000}" \
    -bf "${color7:=#000000}" \
    -cf "${color7:=#000000}" \
    -nf "${color7:=#000000}"
