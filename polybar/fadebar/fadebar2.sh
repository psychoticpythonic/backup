
fade_window_opacity() {
    # Set the target window name
    local window_name="polybar-groups_None-1"

    # Find the window ID
    local window_id=$(xdotool search --name "$window_name" | head -n 1)

    # Check if the window ID was found
    if [ -z "$window_id" ]; then
        echo "Window not found."
        exit 1
    fi

    # Loop to gradually decrease opacity
    while true; do
        local continue_fading=true  # Flag variable to indicate whether to continue the fading loop
        
        for ((opacity = 100; opacity >= 0; opacity--)); do
            # Check if TT:G is detected and immediately restart the loop if detected
            if bspc query -T -d | grep -q 'TT:G'; then
                continue_fading=false
                break  # Exit the inner loop
            fi
            
            # Set window opacity
            xprop -id "$window_id" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $(printf 0x%x $((opacity * 0xffffffff / 100)))
            
            # Sleep for the specified duration (adjust this for smoother or faster fading)
            sleep "$1"
        done
        
        # Check if the fading loop should continue or stop
        if ! $continue_fading; then
            continue  # Restart the outer loop
        else
            break  # Exit the outer loop
        fi
    done
}
