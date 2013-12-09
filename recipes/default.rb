#
# Cookbook Name:: chef-mesos
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt::default'
include_recipe 'chef-mesos'

package 'curl'
package 'wget'
package 'g++'
package 'gcc'

case node['platform_family']
when 'debian ubuntu'
  package 'default-jre-headless'
  package 'default-jre'
  package 'zookeeper-bin'
  package 'zookeeperd'
  package 'python-setuptools'
  package 'python-dev'
  package 'libcurl4-openssl-dev'
  package 'libunwind7-dev'
  package 'libsasl2-2'
  package 'libsasl2-dev'
  package 'libcurl3'
when 'rhel fedora centos' # todo fix this :-)
  package 'default-jre-headless'
  package 'default-jre'
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

packageFile = "#{node.default.mesos.source.dir}/#{node.default.mesos.install.filename}"
localFile = node.default.mesos.install.pkg_local

dpkg_package "mesos_deb" do
  package_name packageFile
  action :nothing
end

dpkg_package "mesos_deb_local" do
  package_name localFile
  action :nothing
end

bash "configure_mesos" do
  cwd node.mesos.source.dir
  code <<-EOH
    ./configure
  EOH
  action :nothing
  notifies :run, "bash[compile_mesos]"
end

bash "compile_mesos" do
  cwd node.mesos.source.dir
  code <<-EOH
    ./configure
    make clean
    make
    sudo make uninstall
    sudo make install
  EOH
  action :nothing
  notifies :run, "bash[install_mesos]"
end


# Separated so we one may debug if necessary
bash "install_mesos" do
  cwd node.mesos.source.dir
  code <<-EOH
    sudo make uninstall
    sudo make install
  EOH
  action :nothing
end


#
# Start
#

directory node.mesos.source.dir do
  # owner "vagrant"
  # group "vagrant"
  mode 00644
  action :create
end


chef_mesos_master "mesos-master" do
  action :create
  only_if do node.mesos.install.mode == "master" end
end

chef_mesos_slave "mesos-slave" do
  action :create
  only_if do node.mesos.install.mode == "slave" end
end

chef_mesos_local "mesos-local" do
  action :create
  only_if do node.mesos.install.mode == "local" end
end
