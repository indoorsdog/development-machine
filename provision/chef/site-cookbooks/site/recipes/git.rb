package "git-core" do
	version node["git"]["version"]
  action :install
end