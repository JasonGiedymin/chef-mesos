case node[:platform]
  when 'debian','ubuntu'
    default['mesos']['package_format'] = 'deb'
  else
    default['mesos']['package_format'] = 'rpm'
end

# misc attribs
default['mesos']['install']['force']         = true # force the install

# packaging
default['mesos']['install']['method']        = pkg # {src|pkg|pkgsrc}

default['mesos']['install']['pkg_ver']       = '0.14.2'
default['mesos']['install']['pkg_arch']      = 'amd64' # right now that is all you get

default['mesos']['install']['filename']      = "mesos_#{default[:mesos][:install][:pkg_ver]}_#{default[:mesos][:install][:pkg_arch]}.#{default[:mesos][:package_format]}"
default['mesos']['install']['pkg_url']       = "http://downloads.mesosphere.io/master/#{node[:platform]}/#{node[:platform_version]}/#{node[:mesos][:install][:filename]}"

# compile
default['mesos']['source']['dir']           = "#{Chef::Config[:file_cache_path]}/mesos" # temporary dir to unpack/compile
default['mesos']['source']['repo']          = 'https://git-wip-us.apache.org/repos/asf/mesos.git'
default['mesos']['source']['branch']        = 'master' # git branch to compile from
