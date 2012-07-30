#
# Cookbook Name:: site
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file '/home/vagrant/builds/indoorsdog/development-machine/test/vagrant_1.0.3_i686.deb' do
  source 'http://files.vagrantup.com/packages/eb590aa3d936ac71cbf9c64cf207f148ddfc000a/vagrant_1.0.3_i686.deb'
end

package 'vagrant_1.0.3_i686.deb' do
  provider Chef::Provider::Package::Dpkg
  source '/home/vagrant/builds/indoorsdog/development-machine/test/vagrant_1.0.3_i686.deb'
  action :install
end

