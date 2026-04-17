#!/bin/bash
SPLUNK_HOME="/opt/splunk"
SPLUNK_LINUXUSER="splunk"
SPLUNK_USER="admin"
#modify the PW
SPLUNK_PW="admin123"

DEST_DIR="/tmp"
FILE_NAME="splunkforwarder-10.2.2-80b90d638de6.x86_64.rpm"
FULL_PATH="$DEST_DIR/$FILE_NAME"
URL="https://download.splunk.com/products/universalforwarder/releases/10.2.2/linux/splunkforwarder-10.2.2-80b90d638de6.x86_64.rpm"

#Installation of dependencies
dnf install wget -y
dnf install net-tools -y

#Download Splunk software
cd /tmp

#Check if the file exists in /tmp
if [ -f "$FULL_PATH" ]; then
    echo "Success: $FULL_PATH already exists. No action needed."
else
    echo "File not found in $DEST_DIR. Downloading..."
    wget -O "$FULL_PATH" "$URL"
fi

#Installation of Splunk
cd /opt
rpm -i $FULL_PATH

chown -R splunk:splunk /opt/splunk

sudo -u $SPLUNK_LINUXUSER $SPLUNK_HOME/bin/splunk start --accept-license --answer-yes --no-prompt --seed-passwd admin123

$SPLUNK_HOME/bin/splunk enable boot-start -user $SPLUNK_LINUXUSER
