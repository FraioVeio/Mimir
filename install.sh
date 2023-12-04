#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Define the source directory of your mimir folder
# Replace this with the actual path where the mimir folder is located
MIMIR_AUDIO_DIR="mimir"

# Define the target directories
MIMIR_AUDIO_TARGET_DIR="/usr/local/share/mimir"
MIMIR_EXECUTABLE_TARGET="/usr/local/bin/mimir"

# Check if the source directory exists
if [ ! -d "$MIMIR_AUDIO_DIR" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

# Copy the mimir folder
echo "Copying audio to $MIMIR_AUDIO_TARGET_DIR..."
cp -r "$MIMIR_AUDIO_DIR" "$MIMIR_AUDIO_TARGET_DIR"

# Set permissions
echo "Setting permissions for $MIMIR_AUDIO_TARGET_DIR..."
chmod -R 755 "$MIMIR_AUDIO_TARGET_DIR"

# Copy the executable
echo "Copying mimir.sh to $MIMIR_EXECUTABLE_TARGET..."
cp "mimir.sh" "$MIMIR_EXECUTABLE_TARGET"

# Set permissions
echo "Setting permissions for $MIMIR_EXECUTABLE_TARGET..."
chmod +x "$MIMIR_EXECUTABLE_TARGET"

# Confirm completion
echo "Installation completed successfully."
