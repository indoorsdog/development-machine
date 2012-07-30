#!/bin/sh

whoami
pwd
cd test
rvmsudo gem install chef --version 10.12.0
rvmsudo gem install librarian --version 0.0.24
rvmsudo librarian-chef install
rvmsudo chef-solo --config ~/builds/indoorsdog/development-machine/test/solo.rb --json-attributes ~/builds/indoorsdog/development-machine/test/node.json
vagrant --version
cd ..
vagrant up
