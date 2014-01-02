# encoding: UTF-8

include_recipe 'apt::default'
include_recipe 'java'

package 'curl'
package 'wget'
package 'g++'
package 'gcc'

case node['platform_family']
when 'debian', 'ubuntu'
  # package 'openjdk-7-jre-headless'
  # package 'openjdk-7-jre-lib'
  # package 'openjdk-7-jre'
  # package 'openjdk-7-jdk'
  package 'zookeeper-bin'
  package 'zookeeperd'
  package 'python-setuptools'
  package 'python-dev'
  package 'libcurl4-openssl-dev'
  package 'libunwind7-dev'
  package 'libsasl2-2'
  package 'libsasl2-dev'
  package 'libcurl3'
when 'amazon', 'scientific', 'centos', 'redhat', 'fedora'
  # package 'openjdk-7-jre-headless'
  # package 'openjdk-7-jre-lib'
  # package 'openjdk-7-jre'
  # package 'openjdk-7-jdk'
  # package 'openjdk-7-jdk'
  package 'zookeeper-bin'
  package 'zookeeperd'
  package 'python-setuptools'
  package 'python-dev'
  package 'libcurl4-openssl-dev'
  package 'libunwind7-dev'
  package 'libsasl2-2'
  package 'libsasl2-dev'
  package 'libcurl3'
end

directory node['mesos']['source']['dir'] do
  # owner "vagrant"
  # group "vagrant"
  mode 00644
  action :create
end

remote_file 'download_file' do
  path package_file('remote')
  source node['mesos']['install']['pkg_url']
  action :create_if_missing
  notifies 'install', 'dpkg_package[mesos_deb]', :immediately
  only_if { node['mesos']['install']['via'] == 'pkg' }
end

git node['mesos']['source']['dir'] do
  repository node['mesos']['source']['repo']
  reference node['mesos']['source']['branch']
  action :sync
  notifies :run, 'bash[configure_mesos]'
  only_if { node['mesos']['install']['via'] == 'src' }
end

dpkg_package 'mesos_deb' do
  package_name package_file('remote')
  only_if { (node['mesos']['install']['via'] == 'pkg') }
  action :install
end

dpkg_package 'mesos_deb_local' do
  package_name node['mesos']['install']['pkg_local']
  action :install
  only_if { node['mesos']['install']['via'] == 'pkg_local' && File.exists?(node['mesos']['install']['pkg_local']) }
end

bash 'configure_mesos' do
  cwd node['mesos']['source']['dir']
  code './configure'
  action :nothing
  notifies :run, 'bash[compile_mesos]'
end

bash 'compile_mesos' do
  cwd node['mesos']['source']['dir']
  code <<-EOH
    ./configure
    make clean
    make
    sudo make uninstall
    sudo make install
  EOH
  action :nothing
  notifies :run, 'bash[install_mesos]'
end

# Separated so we one may debug if necessary
bash 'install_mesos' do
  cwd node['mesos']['source']['dir']
  code <<-EOH
    sudo make uninstall
    sudo make install
  EOH
  action :nothing
end

#
# Recipes
#

chef_mesos_master 'mesos-master' do
  action :create
  only_if { node['mesos']['install']['mode'] == 'master' }
end

chef_mesos_slave 'mesos-slave' do
  action :create
  only_if { node['mesos']['install']['mode'] == 'slave' }
end

chef_mesos_local 'mesos-local' do
  action :create
  only_if { node['mesos']['install']['mode'] == 'local' }
end
