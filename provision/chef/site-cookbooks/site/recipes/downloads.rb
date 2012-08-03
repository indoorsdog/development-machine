require 'json'

def createDir(dir)
  execute 'create dir' do
    command "mkdir -p #{File.dirname(dir)}"
  end
  execute 'chown dir' do
    command "sudo chown -R vagrant:vagrant #{File.dirname(dir)}"
  end
end

json = JSON.parse node[:site][:downloads].to_hash.to_json
json.each_value do |group|
  group.each do |key, value|
    case key
    when 'file'
      value.each do |k, v|
        createDir k
        remote_file k.dup do
          owner 'vagrant'
          group 'vagrant'
          source v
          mode '0754'
        end
      end
    when 'git'
      value.each do |k, v|
        createDir k
        git k do
          repository v
          group 'vagrant'
          user 'vagrant'
          action :checkout
        end
      end
    end
  end
end

# FIXME this is a hack. for some reason the chown-ing that goes on
# in createDir() above doesn't change the ~/.vim folder owner from
# root, even though the folder is definitely in the paths passed by
# Vagrantfile Chef node JSON. the children of .vim are changed
# correctly, just not .vim so we hard-code for now.
execute 'chown .vim' do
  command "sudo chown vagrant:vagrant /home/vagrant/.vim"
end
