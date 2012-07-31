#!/bin/sh

whoami
pwd
lsb_release -irc
cd test
sudo apt-get install --assume-yes virtualbox
wget http://files.vagrantup.com/packages/eb590aa3d936ac71cbf9c64cf207f148ddfc000a/vagrant_1.0.3_i686.deb
sudo dpkg -i vagrant_1.0.3_i686.deb
cd ..

OUT=$?
if [ $OUT -eq 0 ];then
       echo "User account found!"
   else
          echo "User account does not exists in /etc/passwd file!"
      fi
/opt/vagrant/bin/vagrant up
OUT=$?
if [ $OUT -ne 0 ];then
  exit 1
fi
/opt/vagrant/bin/vagrant ssh --command 'touch /vagrant/test/created_in_vm'
OUT=$?
if [ $OUT -ne 0 ];then
  exit 1
fi
ls test
[ -f test/created_in_vm ] && exit 0 || exit 1
