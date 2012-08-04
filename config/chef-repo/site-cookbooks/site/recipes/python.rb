#
# Cookbook Name:: buildgap-shell
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# http://help.opscode.com/discussions/questions/177-append-information-to-a-file
# http://stackoverflow.com/questions/216202/why-does-an-ssh-remote-command-get-fewer-environment-variables-then-when-run-man

template "/etc/profile.d/virtualenv.sh" do
  source "virtualenv.sh.erb"
  mode "0644"
#  variables(
#    :perlbrew_root => perlbrew_root
#  )
end

#file '/home/vagrant/.profile' do
#	additional_content = %Q{
# Begin buildgap changes
#source /home/vagrant/build/python/virtualenv/bin/activate
# End buildgap changes
#}
#	original_content = File.read(path)
#  owner "root"
#  group "root"
#  mode "0644"
#  content (original_content + additional_content)
#  only_if {original_content.index(additional_content).nil?}
#end

# todo figure out how I declare my "dependency" on this
python_virtualenv "/home/vagrant/build/python/virtualenv/" do
  interpreter "python2.7"
  owner "vagrant"
  group "vagrant"
  action :create
  not_if {File.exists?('/home/vagrant/build/python/virtualenv/bin/activate')}
end 
