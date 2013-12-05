#
# Cookbook Name:: chef-mesos
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt::default'

package 'default-jre-headless'
package 'default-jre'
package 'zookeeperd'
package 'python-setuptools'

# service 'mesos-master' do
#   action [:enable, :stop]
# end

# service 'mesos-slave' do
#   action [:enable, :stop]
# end

packageFile = "#{node.default.mesos.source.dir}/#{node.default.mesos.install.filename}"

def checkWorkingDir()
  directory node.mesos.source.dir do
    # owner "vagrant"
    # group "vagrant"
    mode 00644
    action :create
  end
end

def checkForPkgFile()
  remote_file packageFile do
    source node.default.mesos.install.pkg_url
    # owner 'vagrant'
    # group 'vagrant'
    mode 00644
    action :create_if_missing
  end
end

def installPkg() {
  dpkg_package packageFile do
    action :install
  end
}


def prepareSrc()
  git node.mesos.source.dir do
    repository node.mesos.source.repo
    reference node.mesos.source.branch
    action :sync
  end

  bash "configure_mesos" do
    cwd: node.mesos.source.dir
    code <<-EOH
      ./configure
    EOH
  end
end

def compileSrc()
  bash "compile_mesos" do
    cwd: node.mesos.source.dir
    code <<-EOH
      ./configure
      make clean
      make
      sudo make uninstall
      sudo make install
    EOH
  end
end

# Separated so we one may debug if necessary
def installSrc()
  bash "install_mesos" do
    cwd: node.mesos.source.dir
    code <<-EOH
      sudo make uninstall
      sudo make install
    EOH
  end
end

checkWorkingDir()

case node.mesos.install.method
when :pkg
  checkForPkgFile()
  installPkg()
when :pkgsrc
  # not yet ready
when :src
  prepareSrc()
  compileSrc()
  instalSrc()
end
