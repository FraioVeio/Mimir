#!/bin/bash

# Function to display help message
function show_help {
    echo "Usage: $0 [TIME_IN_SECONDS | inf]"
    echo "Put computer to sleep for a specified duration or infinitely."
    echo
    echo "Arguments:"
    echo "  TIME_IN_SECONDS   Sleep duration."
    echo "                    Must be a positive integer."
    echo "  inf               Sleep indefinitely until manually interrupted."
    echo
    echo "Options:"
    echo "  -h, --help        Display this help message and exit."
    echo
    echo "Example:"
    echo "  $0 60             Sleep for 60 seconds."
    echo "  $0 inf            Sleep indefinitely."
    exit 0
}

# Function to handle Ctrl+C interruption
function handle_interrupt {
    echo "Interrupted by user. Exiting."
    exit 1
}

# Trap SIGINT (Ctrl+C) and call the handle_interrupt function
trap handle_interrupt SIGINT

# Check if help is requested
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
fi

# Check if an argument has been provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please specify the time in seconds as the first argument or 'inf' for infinite sleep."
    echo "Use -h or --help for more information."
    exit 1
fi

# Check if the argument is 'inf' for infinite loop
INFINITE_LOOP=false
if [ "$1" = "inf" ]; then
    INFINITE_LOOP=true
elif ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -le 0 ]; then
    echo "Error: The argument must be a positive integer or 'inf'."
    exit 1
else
    DURATION=$1
fi

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
    # Play the audio files without output
    aplay "$FILE1" >/dev/null 2>&1

    # If not in infinite loop, check the elapsed time
    if [ "$INFINITE_LOOP" = false ]; then
        # Get the current timestamp
        NOW=$(date +%s)

        # Calculate elapsed time
        ELAPSED=$(( NOW - START ))

        # Exit the loop if the specified time has elapsed
        if [ $ELAPSED -ge $DURATION ]; then
            break
        fi
    fi

    aplay "$FILE2" >/dev/null 2>&1

    # If not in infinite loop, check the elapsed time
    if [ "$INFINITE_LOOP" = false ]; then
        # Get the current timestamp
        NOW=$(date +%s)

        # Calculate elapsed time
        ELAPSED=$(( NOW - START ))

        # Exit the loop if the specified time has elapsed
        if [ $ELAPSED -ge $DURATION ]; then
            break
        fi
    fi
done