#!/bin/sh

cd test
gem install chef --version 10.12.0
gem install librarian --version 0.0.24
librarian-chef install
sudo -u vagrant chef-solo --config ~/builds/indoorsdog/development-machine/test/solo.rb --json-attributes ~/builds/indoorsdog/development-machine/test/node.json
