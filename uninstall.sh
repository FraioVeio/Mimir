#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Define the target directories
MIMIR_AUDIO_TARGET_DIR="/usr/local/share/mimir"
MIMIR_EXECUTABLE_TARGET="/usr/local/bin/mimir"

# Remove the mimir folder
if [ -d "$MIMIR_AUDIO_TARGET_DIR" ]; then
    echo "Removing $MIMIR_AUDIO_TARGET_DIR..."
    rm -rf "$MIMIR_AUDIO_TARGET_DIR"
else
    echo "Directory $MIMIR_AUDIO_TARGET_DIR does not exist. Skipping."
fi

# Remove the executable
if [ -f "$MIMIR_EXECUTABLE_TARGET" ]; then
    echo "Removing $MIMIR_EXECUTABLE_TARGET..."
    rm "$MIMIR_EXECUTABLE_TARGET"
else
    echo "Executable $MIMIR_EXECUTABLE_TARGET does not exist. Skipping."
fi

# Confirm completion
echo "Uninstallation completed successfully."
