# -*- mode: ruby -*-
# vi: set ft=ruby :

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

  # patches.sh sits alongside this file and should contain scripting updates to the
  # installed dependencies of the vagrant base box, when necessary (e.g. provisioner
  # version bumps). this shell provisioner runs first guaranteeing downstream exposure.
  # the should be temporary, in cases when you can't wait for Vagrant to update their
  # base boxes.
  config.vm.provision :shell, :path => 'config/shell/patches.sh'

  config.vm.provision :chef_solo do |chef|

    chef.log_level = :debug

    chef.cookbooks_path = [[:vm, '/usr/local/chef-repo'], 'config/chef-repo/site-cookbooks']

    chef.add_recipe 'site::packages'
    chef.add_recipe 'site::symlinks'
    chef.add_recipe 'site::downloads'
    chef.add_recipe 'ruby_build'
    chef.add_recipe 'rbenv::user'
    chef.add_recipe 'site::pythonbrew'
    chef.add_recipe 'site::nvm'

    chef.json = {
      'site' => {
        'downloads' => {
	  'vim' =>  {
	    'file' => {
	      '/home/vagrant/.vim/autoload/pathogen.vim' => 'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
            },
	    'git' => {
	      '/home/vagrant/.vim/bundle/vim-colors-solarized' => 'https://github.com/altercation/vim-colors-solarized',
	      '/home/vagrant/.vim/bundle/vim-coffee-script' => 'https://github.com/kchmck/vim-coffee-script.git',
	      '/home/vagrant/.vim/bundle/vim-colorschemes' => 'https://github.com/flazz/vim-colorschemes.git'
            }
          }
        },
        'nvm' => {
          'user_installs' => [
            {
              'user' => 'vagrant',
              'nodes' => [ '0.8.14' ],
              'default' => '0.8.14',
              'npms' => [
                {
                  '0.8.14' => [
                    { 'name' => 'coffee-script', 'version' => '1.3.3' }
                  ]
                }
              ]
            }
          ]
        },
        'packages' => {
          'curl' => '7.22.0-3ubuntu4',
          'libbz2-dev' => '1.0.6-1',
          'git-flow' => '0.4.1-2',
          'tree' => '1.5.3-2',
          'vim' => '2:7.3.429-2ubuntu2.1'
        },
        'pythonbrew' => {
          'user_installs' => [
            {
              'user' => 'vagrant',
              'pythons' => [ '2.7.3' ],
              'venv' => {
                'default' => {
                  'python' => '2.7.3',
                  'pip' => [
                    { 'name' => 'pygments', 'version' => '1.5' }
                  ]
                }
              },
              'defaults' => {
                'python' => '2.7.3',
                'venv' => 'default'
              },
            }
          ]
        },
        'symlinks' => {
          '/vagrant/home/.vimrc' => '/home/vagrant/.vimrc'
        }
      },
      'rbenv' => {
        # can't use latest tag number, something was fixed between it
        # and https://github.com/sstephenson/rbenv/tree/6778c8e905d774d4dc70724c455e6fcff4c1d3e1
        # 'git_ref' => 'v0.3.0',
        'user_installs' => [
          {
            'user' => 'vagrant',
            'rubies' => [ '1.9.3-p194' ],
            'global' => '1.9.3-p194',
            'gems' => {
              '1.9.3-p194' => [
                {
                  'name' => 'tmuxinator',
                  'version' => '0.5.0'
                }
              ]
            }
          }
        ]
      }
    }
  end

end
