json = JSON.parse node[:site][:pythonbrew][:user_installs].to_json
puts json
json.each do |user_install|
  user = user_install['user']
  print 'user=' + user
  print 'pythons=['
  user_install['pythons'].each do |python|
    print python + ' '
  end
  print ']'
  default_python = user_install['defaults']['python']
  default_venv = user_install['defaults']['venv']
  print 'defaults->python=' + default_python
  print 'defaults->venv=' + default_venv
  user_install['venv'].each_pair do |project, packages|
    print project
    Array(packages).each do |package|
      package_name = package['name']
      package_version = package['version']
      print package_name
      print package_version
    end
  end
end
