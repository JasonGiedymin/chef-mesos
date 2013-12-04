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