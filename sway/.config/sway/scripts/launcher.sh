#!/usr/bin/env sh

exec alacritty \
    --class=sway_launcher \
    --title=sway_launcher \
    -e bash -c 'compgen -c | sort -u | fzf --no-extended --print-query | tail -n1 | xargs -r swaymsg -t command exec'
