#!/bin/bash

# Check if Conky is running
if pgrep -x "conky" > /dev/null; then
    # If Conky is running, kill it
    pkill -x conky
else
    # If Conky is not running, start it
    conky &
fi
