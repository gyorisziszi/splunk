#!/bin/bash

# Define the target timezone
ZONE="Europe/Budapest"

# Check if the timezone file exists
if [ -f "/usr/share/zoneinfo/$ZONE" ]; then
    echo "Setting timezone to $ZONE..."
    
    # Set the timezone
    timedatectl set-timezone "$ZONE"
    
    # Sync the hardware clock
    hwclock --systohc
    
    echo "Timezone successfully updated."
    echo "Current local time: $(date)"
else
    echo "Error: Timezone $ZONE not found."
    exit 1
fi
