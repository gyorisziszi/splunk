#!/bin/bash
yum install wget -y
yum install nano -y
yum install net-tools -y
mkdir /opt/git
cd /opt/git
git clone https://github.com/gyorisziszi/splunk.git
