#!/bin/bash

# Function to display help message
function show_help {
    echo "Usage: $0 [TIME_IN_SECONDS | inf] [STANDARD_DEVIATION]"
    echo "Put computer to sleep with sound playback for a specified duration or infinitely with optional speed variation."
    echo
    echo "Arguments:"
    echo "  TIME_IN_SECONDS   Sleep duration."
    echo "                    Must be a positive integer or 'inf' for infinite."
    echo "  STANDARD_DEVIATION Optional speed variation standard deviation."
    echo "                    Must be a positive decimal. Default is 0.1."
    echo
    echo "Options:"
    echo "  -h, --help        Display this help message and exit."
    echo
    echo "Example:"
    echo "  $0 60             Sleep for 60 seconds with default speed variation."
    echo "  $0 60 0.2         Sleep for 60 seconds with 0.2 standard deviation for speed variation."
    echo "  $0 inf            Sleep indefinitely with default speed variation."
    exit 0
}

# Function to handle Ctrl+C interruption
function handle_interrupt {
    exit 1
}

# Trap SIGINT (Ctrl+C) and call the handle_interrupt function
trap handle_interrupt SIGINT

# Check if help is requested
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
fi

# Check if an argument has been provided
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Error: Incorrect number of arguments."
    echo "Use -h or --help for more information."
    exit 1
fi

# Check if the first argument is 'inf' for infinite loop
INFINITE_LOOP=false
if [ "$1" = "inf" ]; then
    INFINITE_LOOP=true
elif ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -le 0 ]; then
    echo "Error: The first argument must be a positive integer or 'inf'."
    exit 1
else
    DURATION=$1
fi

# Set default standard deviation and check if the second argument is provided
STANDARD_DEVIATION=0.1
if [ -n "$2" ]; then
    if ! [[ "$2" =~ ^[0-9]+(\.[0-9]+)?$ ]] || (( $(echo "$2 <= 0" | bc -l) )); then
        echo "Error: The second argument must be a positive decimal."
        exit 1
    else
        STANDARD_DEVIATION=$2
    fi
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

# Parameters for Gaussian distribution
MEAN=1.0

# Function to generate a random speed using Gaussian distribution with /dev/urandom
function generate_random_speed {
    mean=$MEAN
    sd=$STANDARD_DEVIATION
    while true; do
        # Read 4 bytes from /dev/urandom and convert them to a float in the range [0,1)
        u1=$(od -An -N4 -tu4 < /dev/urandom | awk '{print $1 / 4294967296}')
        u2=$(od -An -N4 -tu4 < /dev/urandom | awk '{print $1 / 4294967296}')

        # Box-Muller transform
        z0=$(awk -v u1=$u1 -v u2=$u2 'BEGIN {print sqrt(-2 * log(u1)) * cos(2 * atan2(0, -1) * u2)}')
        z1=$(awk -v u1=$u1 -v u2=$u2 'BEGIN {print sqrt(-2 * log(u1)) * sin(2 * atan2(0, -1) * u2)}')

        # Calculate the result and check if it is a positive value
        result=$(awk -v z0=$z0 -v mean=$mean -v sd=$sd 'BEGIN {print z0 * sd + mean}')
        if (( $(echo "$result > 0" | bc -l) )); then
            echo $result
            break
        fi
    done
}

# Loop to play the files until the time has elapsed
while true; do
    # Generate a random speed using Gaussian distribution
    SPEED=$(echo "scale=2; 1/$(generate_random_speed)" | bc)

    # echo $SPEED

    # Play the audio file with the randomized speed
    sox "$FILE1" -d tempo $SPEED >/dev/null 2>&1

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

    # Generate a random speed again using Gaussian distribution
    SPEED=$(echo "scale=2; 1/$(generate_random_speed)" | bc)

    # echo $SPEED

    # Play the audio file with the randomized speed
    sox "$FILE2" -d tempo $SPEED >/dev/null 2>&1

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