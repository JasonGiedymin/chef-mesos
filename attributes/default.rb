def packageType()
  case node[:platform]
    when 'debian','ubuntu'
      'deb'
    else
      'rpm'
  end
end

# misc attribs
default['mesos']['install']['force']         = true # force the install

# packaging
default['mesos']['install']['from_package']  = true # flag to declare if install should start from a pre- packaged binary
default['mesos']['install']['pkg_ver']       = '0.14.2'
default['mesos']['install']['pkg_arch']      = 'amd64' # right now that is all you get
default['mesos']['install']['pkg_url']       = "http://downloads.mesosphere.io/master/#{node[:platform]}/#{node[:platform_version]}/mesos_#{default['install']['pkg_ver']}_#{default['install']['pkg_ver']}.#{packageType()}"

# compile
default['mesos']['compile']['dir']           = '~/temp' # temporary dir to unpack/compile
default['mesos']['compile']['branch']        = 'master' # git branch to compile from
