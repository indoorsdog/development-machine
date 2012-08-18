require 'json'

json = JSON.parse node[:site][:nvm][:user_installs].to_json
json.each do |user_install|
  user = user_install['user']
  nvmDir = "/home/#{user}/nvm"
  defaultNode = user_install['default']
  git nvmDir do
    repository 'https://github.com/creationix/nvm.git'
    group user
    user user
    action :checkout
  end
  template '/etc/profile.d/nvm.sh' do
    mode '0755'
    owner 'root'
    source 'nvm.sh.erb'
  end
  package 'curl'
  package 'make'
  package 'build-essential'
  user_install['nodes'].each do |nodejs|
    script "installing nodejs version #{nodejs} for user #{user}..." do
      interpreter "bash"
      user user
      environment Hash[ 'HOME' => "/home/#{user}" ]
      flags '-l'
      code <<-EOH
      nvm install v#{nodejs}
      EOH
    end
  end
  script "setting nodejs version #{defaultNode} as default nodejs for user #{user}..." do
    interpreter "bash"
    user user
    environment Hash[ 'HOME' => "/home/#{user}" ]
    flags '-l'
    code <<-EOH
    # TODO verify default is in installed versions array
    # also what about node < 0.6? no auto-npm install
    nvm alias default v#{defaultNode}
    EOH
  end
  user_install['npms'].each do |npm|
    npm.each_pair do |ver, modules|
      puts "installing global modules for nodejs version #{ver} for user #{user}..."
      modules.each do |mod|
        script "installing #{mod['name']}\@#{mod['version']}..." do
          interpreter "bash"
          user user
          environment Hash[ 'HOME' => "/home/#{user}" ]
          flags '-l'
          code <<-EOH
          # TODO verify node versions are in installed versions array
          # also setting 'nvm use <version>' in this loop is inelegant
          nvm use #{ver}
          npm install #{mod['name']}@#{mod['version']} -g
          EOH
        end
      end
    end
  end
end
