node[:gems].each do |gem|
  execute "/bin/bash -lc \"gem install #{gem}\"" do
    not_if "/bin/bash -lc \"gem list | grep #{gem}\""
    user "#{node[:user]}"
  end
end

execute "/bin/bash -lc \"gem install rails -v #{node[:rails_version]}\"" do
  not_if "/bin/bash -lc \"rails -v | grep #{node[:rails_version]}\""
  user "#{node[:user]}"
end
