node[:site][:rubygems].each do |gemname, version|
  gem_package gemname do
    version version
    action :install
  end
end
