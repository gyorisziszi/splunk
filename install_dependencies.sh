#!/bin/bash
yum install git -y
yum install wget -y
yum install nano -y
yum install bind-utils -y
yum install net-tools -y
yum install epel-release -y
yum install htop -y

#install and enable ssh
sudo yum install -y openssh-server
sudo systemctl start sshd
sudo systemctl enable sshd

#bash install_splunk_ent.sh
#bash install_splunk_uf.sh
setfacl -R -d -m u:splunk:rwx /opt/splunk
setfacl -R -d -m u:splunk:rwx /opt/git