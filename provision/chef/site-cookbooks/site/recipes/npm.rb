require 'json'
json = JSON.parse node[:site][:npm].to_hash.to_json
json.each do |name, version|
  npm_package name do
    version version
  end
end
