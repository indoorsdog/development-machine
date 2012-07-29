node[:site][:symlinks].each do |source_file, link_name|
  link link_name do
    to source_file
  end
end
