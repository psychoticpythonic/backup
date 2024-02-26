#!/bin/bash

# Set the CPU usage threshold
threshold=20

# Get the list of processes exceeding the threshold
processes=$(ps -eo pid,%cpu,comm --sort=-%cpu | awk -v thresh="$threshold" '$2 > thresh {print $1,$3}')

# Check if there are any processes exceeding the threshold
if [ -n "$processes" ]; then
    # Display a notification using Dunst
    dunstify "High CPU Usage" "$processes"
fi
