#!/bin/bash

# Variables
USERNAME="szilard"
PASSWORD="admin123"

# 1. Create the user
# -m creates the home directory
useradd -m "$USERNAME"

# 2. Set the password
# Using chpasswd for non-interactive password setting
echo "$USERNAME:$PASSWORD" | chpasswd

# 3. Add to sudoers (wheel group in CentOS)
usermod -aG wheel "$USERNAME"

# 4. Enable SSH access
# Ensure the .ssh directory exists with correct permissions
mkdir -p /home/$USERNAME/.ssh
chmod 700 /home/$USERNAME/.ssh
touch /home/$USERNAME/.ssh/authorized_keys
chmod 600 /home/$USERNAME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo "User $USERNAME has been created and configured."
