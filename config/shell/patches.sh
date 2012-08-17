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

# git
gitVer=`git --version`
if [[ $gitVer =~ 1\.7\.9\.5 ]]
then
    echo git version up-to-date. not updating.
else
    echo "$gitVer. updating..."
    sudo apt-get install git=1:1.7.9.5-1 --assume-yes
fi

#download chef cookbooks
#https://github.com/applicationsonline/librarian
if [ ! `which librarian-chef` ]; then
    "installing librarian-chef..."
    gem  install librarian --version 0.0.24
    mkdir /usr/local/chef-repo
    cp /vagrant/config/chef-repo/Cheffile /usr/local/chef-repo/Cheffile
    cp /vagrant/config/chef-repo/Cheffile.lock /usr/local/chef-repo/Cheffile.lock
    cd /usr/local/chef-repo
    librarian-chef install --verbose
fi
