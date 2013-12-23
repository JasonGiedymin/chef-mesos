name             'chef-mesos'
maintainer       'Jason Giedymin'
maintainer_email 'jasong@apache.org'
license          'Apache 2'
description      'Installs/Configures mesos'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ amazon scientific centos redhat fedora ubuntu debian }.each do |os|
  supports os
end

# Ubuntu
depends 'apt'

# Centos
depends 'yum'

# Generic
depends 'build-essential'
depends 'java'
depends 'ark'