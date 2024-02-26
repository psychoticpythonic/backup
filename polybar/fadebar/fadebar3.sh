#!/bin/bash

fade_window_opacity() {
    # Set the target window name
    local window_name="polybar-groups_None-1"

    while true; do16
        # Find the window ID
        local window_id=$(xdotool search --name "$window_name" | head -n 1)

        # Check if the window ID was found
        if [ -z "$window_id" ]; then
            echo "Window not found."
            exit 1
        fi

        local continue_loop=1

        # Loop to gradually decrease opacity
        for ((opacity = 100; opacity >= 0 && continue_loop == 1; opacity--)); do
            if [ $continue_loop -eq 1 ]; then
                xprop -id "$window_id" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $(printf 0x%x $((opacity * 0xffffffff / 100)))
                if [ -n "$(bspc subscribe | grep 'TT:G$')" ]; then
                    continue_loop=0
                fi
            fi
            sleep "$1"
        done
    done
}

fade_window_opacity 0.005 1

