#!/bin/bash

# chef
chefVer=`chef-client -v`
if [[ $chefVer =~ 10\.12\.0 ]]
then
    echo chef version up-to-date. not updating.
else
    echo "$chefVer. updating..."
    sudo dpkg --purge chef chef-full
    wget -nv -O - http://opscode.com/chef/install.sh | sudo bash
fi

#download chef cookbooks
#https://github.com/applicationsonline/librarian
sudo apt-get install git=1:1.7.9.5-1 --assume-yes
gem  install librarian --version 0.0.24
mkdir /usr/local/chef-repo
cp /vagrant/config/chef-repo/Cheffile /usr/local/chef-repo/Cheffile
cp /vagrant/config/chef-repo/Cheffile.lock /usr/local/chef-repo/Cheffile.lock
cd /usr/local/chef-repo
librarian-chef install --verbose

