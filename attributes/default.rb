case node[:platform]
  when 'debian','ubuntu'
    default['mesos']['package_format'] = 'deb'
  else
    default['mesos']['package_format'] = 'rpm'
end

# == misc attribs ==
default['mesos']['install']['force']         = false # force the re-install
default['mesos']['install']['resolve']       = false # if local cannot be found, we go out to the net (see below uri)

# where mesos will be installed
default['mesos']['install']['prefix']        = '/usr/local/sbin'
default['mesos']['install']['local_prefix']  = '/usr/local/bin'

# below is for reference, this cookbook doesn't use this, but others do.
# Knowing about it helps us.
default['mesos']['install']['local_script']  = 'mesos-local'
default['mesos']['install']['master_script'] = 'mesos-master'
default['mesos']['install']['slave_script']  = 'mesos-slave'

# == packaging ==
default['mesos']['install']['mode']          = "local" # {master|slave|local}
default['mesos']['install']['via']           = "pkg" # {src|pkg_local|pkg} TODO: handle pkg_local
default['mesos']['install']['pkg_ver']       = '0.14.2'
default['mesos']['install']['pkg_arch']      = 'amd64' # right now that is all you get
default['mesos']['install']['filename']      = "mesos_#{default[:mesos][:install][:pkg_ver]}_#{default[:mesos][:install][:pkg_arch]}.#{default[:mesos][:package_format]}"
default['mesos']['install']['pkg_url']       = "http://downloads.mesosphere.io/master/#{node[:platform]}/#{node[:platform_version]}/#{node[:mesos][:install][:filename]}"
default['mesos']['install']['pkg_local']     = "/tmp/#{node[:mesos][:install][:filename]}" # "/Volumes/Cache/mesos/#{node[:mesos][:install][:filename]}"

# == compile ==
default['mesos']['source']['dir']            = "#{Chef::Config[:file_cache_path]}/mesos" # temporary dir to unpack/compile
default['mesos']['source']['repo']           = 'https://git-wip-us.apache.org/repos/asf/mesos.git'
default['mesos']['source']['branch']         = 'master' # git branch to compile from

# == conf file settings ==
default[:mesos][:conf][:log_location]        = '/var/log/mesos'
default[:mesos][:conf][:ulimit]              = '-n 8192'
default[:mesos][:conf][:zookeepers]          = "zk://#{node[:fqdn]}:2181/mesos" # used by masters to find zookeeper
default[:mesos][:conf][:masters]             = "zk://#{node[:fqdn]}:2181/mesos" # used by slaves
default[:mesos][:conf][:options]             = "--log_dir=$LOGS"
