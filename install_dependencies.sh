#!/bin/bash
yum install git -y
yum install wget -y
yum install nano -y
yun install bind-utils -y
yum install net-tools -y

#install and enable ssh
sudo yum install -y openssh-server
sudo systemctl start sshd
sudo systemctl enable sshd

mkdir /opt/git
cd /opt/git
git clone https://github.com/gyorisziszi/splunk.git
cd /opt/git/splunk
#bash install_splunk_ent.sh
#bash install_splunk_uf.sh
