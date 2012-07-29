require 'json'
json = JSON.parse node[:site][:downloads].to_hash.to_json
json.each_value do |group|
  group.each do |key, value|
    case key
    when 'file'
      value.each do |k, v|
        execute 'create dir' do
          command "mkdir -p #{File.dirname(k)}"
        end
        remote_file k do
          source v
          mode '777'
        end
      end
    when 'git'
      value.each do |k,v|
        execute 'create dir' do
          command "mkdir -p #{File.dirname(k)}"
        end
        git k do
          repository v
          action :checkout
        end
      end
    end
  end
end
