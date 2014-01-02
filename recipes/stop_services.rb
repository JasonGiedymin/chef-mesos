# encoding: UTF-8

# services_start

service 'mesos-local' do # Nope, kill it for good
  case node['platform_family']
  when 'debian', 'ubuntu'
    provider Chef::Provider::Service::Upstart
  end

  supports stop: true
  action :stop
end

# For safety, in-case someone installed chef over an existing install
# by another script/app
service 'mesos' do # Not us, kill it for good
  case node['platform_family']
  when 'debian', 'ubuntu'
    provider Chef::Provider::Service::Upstart
  end

  supports status: true, start: true, stop: true, restart: true
  action :stop
end

service 'zookeeper' do
  case node['platform_family']
  when 'debian', 'ubuntu'
    provider Chef::Provider::Service::Upstart
  end

  supports status: true, start: true, stop: true, restart: true
  action :stop
end

service 'mesos-master' do # All us
  case node['platform_family']
  when 'debian', 'ubuntu'
    provider Chef::Provider::Service::Upstart
  end

  supports status: true, start: true, stop: true, restart: true
  only_if { ![:master, :local].find { |x| x.to_s == install_mode }.nil? }
  action :stop
end

service 'mesos-slave' do # All us
  case node['platform_family']
  when 'debian', 'ubuntu'
    provider Chef::Provider::Service::Upstart
  end

  supports status: true, start: true, stop: true, restart: true
  only_if { ![:slave, :local].find { |x| x.to_s == install_mode }.nil? }
  action :stop
end
