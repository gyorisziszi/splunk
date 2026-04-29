#!/bin/bash

# Check for root/sudo privileges (required to write to /etc/)
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo."
   exit 1
fi

# 1. Define your aliases
declare -A ALIASES=(
    ["ll"]="ls -lah --color=auto"
    ["h"]="history"
    ["tail_splunk"]="sudo tail -f /opt/splunk/var/log/splunk/splunkd.log"
    ["git_clone"]="cd /opt/git && git clone https://github.com/gyorisziszi/splunk.git"
    ["git_pull"]="git --git-dir=/opt/git/splunk/.git --work-tree=/opt/git/splunk pull"
    ["git_del_repo"]="rm -rf /opt/git/splunk"
    ["alias_install"]="bash /opt/git/splunk/install_aliases.sh"
    ["su_splunk"]="su - splunk"
    ["su_szilard"]="su - szilard"
    ["install_all"]="bash /opt/git/splunk/install_all.sh"
    ["sudo_splunk"]="sudo /opt/splunk/bin/splunk"
    ["apply_cluster_bundle"]="/opt/splunk/bin/splunk apply cluster-bundle"
)

# Target global configuration file
GLOBAL_ALIAS_FILE="/etc/profile.d/splunk_aliases.sh"

echo "Creating/Updating global aliases in $GLOBAL_ALIAS_FILE..."

# Clear the file first to avoid duplicates
echo "# Global Splunk Aliases" > "$GLOBAL_ALIAS_FILE"

# 2. Loop through and add them to the global file
for name in "${!ALIASES[@]}"; do
    command="${ALIASES[$name]}"
    echo "alias $name='$command'" >> "$GLOBAL_ALIAS_FILE"
    echo "Configured: '$name'"
done

# 3. Set correct permissions (readable by all)
chmod 644 "$GLOBAL_ALIAS_FILE"

echo "---"
echo "Done! Aliases are now global."
echo "Users must log out and back in, or run: source $GLOBAL_ALIAS_FILE"