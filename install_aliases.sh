#!/bin/bash

# 1. Define your aliases in a "Key=Value" format
# Format: ["short_name"]="full command"
declare -A ALIASES=(
    ["ll"]="ls -lah --color=auto"
    ["h"]="history"
    ["tail_splunk"]="sudo tail -f /opt/splunk/var/log/splunk/splunkd.log"
    ["git_clone"]="cd /opt/git && git clone https://github.com/gyorisziszi/splunk.git"
    ["git_pull"]="git --git-dir=~/splunk/.git --work-tree=~/splunk pull"
)

RC_FILE="$HOME/.bashrc"

echo "Updating $RC_FILE..."

# 2. Loop through the list
for name in "${!ALIASES[@]}"; do
    command="${ALIASES[$name]}"
    
    # Check if alias already exists
    if grep -q "alias $name=" "$RC_FILE"; then
        echo "Skipping: '$name' already exists."
    else
        echo "Adding: '$name' -> $command"
        echo "alias $name='$command'" >> "$RC_FILE"
    fi
done

source $RC_FILE/.bashrc

# 3. Final instruction
echo "---"
echo "Done! To use them now, run: source ~/.bashrc"
