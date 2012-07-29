# -*- mode: ruby -*-
# vi: set ft=ruby :

librarian_name = 'librarian'
librarian_version = '0.0.24'
begin
  Gem::Specification.find_by_name(librarian_name, librarian_version)
rescue Gem::LoadError
  begin
    require 'vagrant/environment'
    env = Vagrant::Environment.new
    env.cli('gem', 'install', librarian_name, '--version', librarian_version)
  rescue SystemExit
  end
end

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.host_name = 'development'

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, '10.151.151.151', :netmask => '255.255.0.0'

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
  # config.vm.share_folder("home", "/home/vagrant", "home/vagrant", :nfs => true)
  # config.vm.share_folder("v-root", "/vagrant", ".", :nfs => true)

  config.vm.provision :chef_solo do |chef|

    chef.log_level = :debug

    require 'librarian/chef/cli'

    # todo, yes this chdir stuff is a hack, figure out how to fix it
    originalDir = Dir.pwd
    Dir.chdir('provision/chef')
    cli = Librarian::Chef::Cli.new
    cli.install
    Dir.chdir(originalDir)

    chef.cookbooks_path = ['provision/chef/cookbooks', 'provision/chef/site-cookbooks']

    chef.add_recipe 'site::packages'
    chef.add_recipe 'site::symlinks'
    chef.add_recipe 'site::rubygems'
#    chef.add_recipe 'site::npm'

    chef.add_recipe 'build-essential'

    # http://grahamwideman.wikispaces.com/Python-+import+statement
    # pip install -r requirements.txt
#    chef.add_recipe 'python::source'
#    chef.add_recipe 'python::pip'
#    chef.add_recipe 'python::virtualenv'
#    chef.add_recipe 'site::python'

    # package.json
    # npm install -d
    # http://tnovelli.net/blog/blog.2011-08-27.node-npm-user-install.html
#    chef.add_recipe 'nodejs'

#    chef.add_recipe 'vim'
#    chef.add_recipe 'tmux'

    chef.json = {
      'site' => {
        'download' => {
	  'vim' =>  {
	    'file' => {
	      '/home/vagrant/.vim/autoload/pathogen.vim' => 'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
            },
	    'git' => {
	      '/home/vagrant/.vim/bundle' => 'https://github.com/altercation/vim-colors-solarized',
	      '/home/vagrant/.vim/bundle' => 'https://github.com/kchmck/vim-coffee-script.git'
            }
          } 
        },
        'npm' => {
      	  'coffee-script' => '1.3.3'
        },
        'packages' => {
          'git' => '1:1.7.9.5-1',
          'git-flow' => '0.4.1-2',
          'git-man' => '1:1.7.9.5-1',
	  'nodejs' => '0.6.12~dfsg1-1ubuntu1',
	  'npm' => '1.1.4~dfsg-1',
          'tree' => '1.5.3-2',
          'vim' => '2:7.3.429-2ubuntu2.1'
        },
        'rubygems' => {
          'tmuxinator' => '0.5.0'
        },
        'symlinks' => {
          '/vagrant/home/.vimrc' => '/home/vagrant/.vimrc'
        }
      },
      'nodejs' => {
        'version' => '0.8.2'
      },
      'python' => {
        'version' => '3.2.3',
        'distribute_install_py_version' => '3.2'
      },
    }
  end

end
