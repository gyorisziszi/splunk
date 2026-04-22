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

# 1. Update the LC_TIME variable to a locale that uses 24h format
# en_DK or en_GB are common choices for 24h time in English
localectl set-locale LC_TIME=en_GB.UTF-8

# 2. Alternatively, you can force the entire system to use a specific locale
# localectl set-locale LANG=en_US.UTF-8 LC_TIME=en_GB.UTF-8

# 3. Source the changes so they apply to the current shell
source /etc/locale.conf

echo "Time format has been updated to 24h (en_GB locale)."
echo "Current time: $(date)"
