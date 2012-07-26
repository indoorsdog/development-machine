node[:packages].each do |pkg, pkg_version_number|
  package pkg do
    version pkg_version_number
    action :install
  end
end