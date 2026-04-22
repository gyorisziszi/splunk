#!/bin/bash

# 1. Define your aliases in a "Key=Value" format
# Format: ["short_name"]="full command"
declare -A ALIASES=(
    ["ll"]="ls -lah --color=auto"
    ["h"]="history"
    ["tail_splunk"]="sudo tail -f /opt/splunk/var/log/splunk/splunkd.log"
    ["git_clone"]="cd /opt/git && git clone https://github.com/gyorisziszi/splunk.git"
    ["git_pull"]="git --git-dir=/opt/git/splunk/.git --work-tree=/opt/splunk/git/splunk pull"
    ["git_del_repo"]="rm -rf /opt/git/splunk"
    ["alias_install"]="bash /opt/splunk/git/install_aliases.sh"
)

RC_FILE="$HOME/.bashrc"
TEMP_FILE=$(mktemp)

echo "Updating $RC_FILE..."

# 2. Remove ALL existing aliases from the list first
for name in "${!ALIASES[@]}"; do
    grep -v "alias $name=" "$RC_FILE" > "$TEMP_FILE"
    mv "$TEMP_FILE" "$RC_FILE"
    echo "Replaced: '$name'"
done

# 3. Add them back fresh
for name in "${!ALIASES[@]}"; do
    command="${ALIASES[$name]}"
    echo "Adding: '$name' -> $command"
    echo "alias $name='$command'" >> "$RC_FILE"
done

source "$RC_FILE"

# 4. Final instruction
echo "---"
echo "Done! Aliases updated. Run 'source ~/.bashrc' if needed."
