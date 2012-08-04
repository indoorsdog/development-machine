#!/bin/bash
echo ****** HELLO WORLD ******
sudo dpkg --purge chef chef-full
wget -O - http://opscode.com/chef/install.sh | sudo bash
#sudo apt-get update && sudo aptitude safe-upgrade -y --allow-new-upgrades --allow-new-installs
