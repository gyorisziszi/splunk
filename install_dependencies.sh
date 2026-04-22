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

#bash install_splunk_ent.sh
#bash install_splunk_uf.sh
