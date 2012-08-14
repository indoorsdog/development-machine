json = JSON.parse node[:site][:pythonbrew][:user_installs].to_json
puts json

def install_pythonbrew(user)
  # TODO: need to install this stuff here?
  # TODO: python and/or pythonbrew doesn't seem to take care of installing these
  # TODO: and they are needed for some installs
  script 'ensure_curl_installed' do
    interpreter 'bash'
    code <<-EOH
    apt-get install curl --assume-yes
    apt-get install patch --assume-yes
    apt-get install build-essential --assume-yes
    EOH
  end
  script "install_pythonbrew(#{user})" do
    interpreter 'bash'
    user user
    code <<-EOH
    # TODO: until can figure out home - http://tickets.opscode.com/browse/CHEF-2288
    export HOME=/home/#{user}

    curl -kL http://xrl.us/pythonbrewinstall | bash
    EOH
  end
  template '/etc/profile.d/pythonbrew.sh' do
    mode '0644'
    source 'pythonbrew.sh.erb'
  end
end

def install_python(user, python)
  script "install_pythonbrew(#{user}, #{python})" do
    interpreter 'bash'
    user user
    environment Hash[ 'HOME' => '/home/vagrant' ]
    flags '-l'
    code <<-EOH
    pythonbrew install #{python} --verbose
    EOH
  end
end

def create_venv(user, python, project)
  script "create_venv(#{user}, #{python}, #{project})" do
    interpreter 'bash'
    user user
    environment Hash[ 'HOME' => '/home/vagrant' ]
    flags '-l'
    code <<-EOH
    pythonbrew use #{python}
    pythonbrew venv create #{project}
    EOH
  end
end

def install_package(user, python, project, package_name, package_version)
  script "install_package(#{user}, #{python}, #{project}, #{package_name}, #{package_version})" do
    interpreter 'bash'
    user user
    environment Hash[ 'HOME' => '/home/vagrant' ]
    flags '-l'
    code <<-EOH
    pythonbrew use #{python}
    pythonbrew venv use #{project}
    pip install #{package_name}==#{package_version}
    EOH
  end
end

json.each do |user_install|
  install_pythonbrew user_install['user']
  user_install['pythons'].each do |python|
    install_python(user_install['user'], python)
  end
  user_install['venv'].each_pair do |project, details|
    create_venv(user_install['user'], details['python'], project)
    Array(details['pip']).each do |package|
      install_package(user_install['user'], details['python'], project, package['name'], package['version'])
    end
  end
  default_python = user_install['defaults']['python']
  default_venv = user_install['defaults']['venv']
  print 'defaults->python=' + default_python
  print 'defaults->venv=' + default_venv
end
