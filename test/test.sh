#!/bin/sh

whoami
pwd
lsb_release -irc
cd test
sudo apt-get install --assume-yes virtualbox
wget http://files.vagrantup.com/packages/eb590aa3d936ac71cbf9c64cf207f148ddfc000a/vagrant_1.0.3_i686.deb
sudo dpkg -i vagrant_1.0.3_i686.deb
cd ..
/opt/vagrant/bin/vagrant up
