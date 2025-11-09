#!/usr/bin/env sh
PREVIOUS=""
while true; do

    PID=$(pidof swaybg)
    WALLPAPERS=$(find $HOME/.config/sway/wallpapers -type f \( -name '*.png' -o -name '*.jpg' \))

    COUNT=$(echo "$WALLPAPERS" | wc -l)

    if [ "$COUNT" -eq 1 ]; then
        FILE="$WALLPAPERS"
    else
        while true; do
            FILE=$(echo "$WALLPAPERS" | shuf -n1)
            [ "$FILE" != "$PREVIOUS" ] && break
        done
    fi

    swaybg -i "$FILE" -m fill &

    if [ -n "$PID" ]; then
        kill "$PID"
    fi

    PREVIOUS="$FILE"

    sleep 599
done
