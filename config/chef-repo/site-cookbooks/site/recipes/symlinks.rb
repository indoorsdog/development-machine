node[:site][:symlinks].each do |source_file, link_name|
  link link_name do
    owner 'vagrant'
    group 'vagrant'
    to source_file
  end
end
