#!/bin/bash

# Function to handle Ctrl+C interruption
function handle_interrupt {
    # echo "Interrupted by user. Exiting."
    exit 1
}

# Trap SIGINT (Ctrl+C) and call the handle_interrupt function
trap handle_interrupt SIGINT

# Check if an argument has been provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please specify the time in seconds as the first argument."
    exit 1
fi

# Duration in seconds
DURATION=$1

# Starting timestamp
START=$(date +%s)

# Paths to the audio files - replace with your files
FILE1="/usr/local/share/mimir/esleep1.wav"
FILE2="/usr/local/share/mimir/esleep2.wav"

# Check if the files exist
if [ ! -f "$FILE1" ] || [ ! -f "$FILE2" ]; then
    echo "Error: One or both audio files do not exist."
    exit 1
fi

# Loop to play the files until the time has elapsed
while true; do
    # Get the current timestamp
    NOW=$(date +%s)

    # Calculate elapsed time
    ELAPSED=$(( NOW - START ))

    # Exit the loop if the specified time has elapsed
    if [ $ELAPSED -ge $DURATION ]; then
        break
    fi

    # Play the audio files without output
    aplay "$FILE1" >/dev/null 2>&1

    # Recheck to handle Ctrl+C during aplay execution
    NOW=$(date +%s)
    ELAPSED=$(( NOW - START ))
    if [ $ELAPSED -ge $DURATION ]; then
        break
    fi

    aplay "$FILE2" >/dev/null 2>&1
done

echo "Completed."
