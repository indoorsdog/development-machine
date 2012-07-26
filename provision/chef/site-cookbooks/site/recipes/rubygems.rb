node[:rubygems].each do |GEMNAME, version|
  gem_package GEMNAME do
    version version
    action :install
  end
end