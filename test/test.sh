#!/bin/sh

whoami
sudo whoami
pwd
cd test
sudo gem install chef --version 10.12.0
sudo gem install librarian --version 0.0.24
sudo librarian-chef install
# yes this sudo stuff is nonsense, but I just want to get it to run
#sudo chmod 777 -R /etc/apt
#sudo chmod 777 -R /var/lib
#sudo chmod 777 -R /var/cache
sudo chef-solo --config ~/builds/indoorsdog/development-machine/test/solo.rb --json-attributes ~/builds/indoorsdog/development-machine/test/node.json
