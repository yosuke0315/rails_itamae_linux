# selinux disabled
package 'libselinux-utils'

execute 'setenforce 0' do
  not_if 'getenforce | grep Disabled'
end

template '/etc/selinux/config' do
  variables(selinux: 'disabled')
  source './selinux/config.erb'
end

# disallow root SSH access
# disallow password authentication
file '/etc/ssh/sshd_config' do
  mode '777'
end

file '/etc/ssh/sshd_config' do
  user 'root'
  action :edit
  block do |content|
    content.gsub!(/#PermitRootLogin yes/, 'PermitRootLogin no')
    content.gsub!(/#PasswordAuthentication yes/, 'PasswordAuthentication no')
  end
  mode '600'
end

package 'epel-release'

package "http://rpms.famillecollet.com/enterprise/remi-release-#{node[:platform_version][0]}.rpm" do
  not_if 'rpm -q remi-release'
end

# kernel-devel install
package 'ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/6.4/x86_64/updates/security/kernel-devel-2.6.32-358.23.2.el6.x86_64.rpm' do
  user 'root'
  not_if 'rpm -qa | grep kernel-devel'
end

execute "yum groupinstall -y 'Development Tools'"

package 'git'
package 'curl'
package 'wget'
package 'tar'
package 'make'
package 'zlib-devel'
package 'ruby-devel'
package 'readline-devel'
package 'ncurses-devel'
package 'openssl'
package 'openssl-devel'
package 'sqlite-devel'
package 'libyaml'
package 'libyaml-devel'
package 'tcl-devel'
package 'db4-devel'
package 'libffi-devel'
package 'libxml2'
package 'libxml2-devel'
package 'libxslt'
package 'libxslt-devel'
package 'vim'