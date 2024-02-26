#!/bin/bash

fade_window_opacity() {
    local window_name="polybar-groups_None-1"
    local window_id=$(xdotool search --name "$window_name" | head -n 1)
    if [ -z "$window_id" ]; then
        echo "Window not found."
        exit 1
    fi
    for ((opacity = 100; opacity >= 0; opacity--)); do
        xprop -id "$window_id" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $(printf 0x%x $((opacity * 0xffffffff / 100)))
        sleep "$1"
        done
}

bspc subscribe | while read -r event; do
    if [[ $(echo "$event" | grep 'TT:G$') ]]; then
        fade_window_opacity 0.005
    fi
done



