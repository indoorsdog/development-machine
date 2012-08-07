#!/bin/bash
echo ****** HELLO WORLD ******
sudo dpkg --purge chef chef-full
wget -O - http://opscode.com/chef/install.sh | sudo bash
#sudo apt-get update && sudo aptitude safe-upgrade -y --allow-new-upgrades --allow-new-installs

#download chef cookbooks
#https://github.com/applicationsonline/librarian
sudo apt-get install git=1:1.7.9.5-1 --assume-yes
gem  install librarian --version 0.0.24
cd /vagrant/config/chef-repo
librarian-chef install --verbose

