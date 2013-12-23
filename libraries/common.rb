def packageFile(mode)
  case mode
  when 'local'
    node[:mesos][:install][:pkg_local]
  when 'remote'
    "#{node[:mesos][:source][:dir]}/#{node[:mesos][:install][:filename]}"
  end
end

def sayHello
  bannerLog "CHEF-MESOS v#{version}"
end


# mode:{local|master|slave|other}
def serviceMesos(serviceAction='stop', mode='local')
  service 'zookeeper' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :start => true, :stop => true, :restart => true
    action serviceAction
  end

  case mode
  when 'local'
    # Some distros around have this, we only support stop if so
    # and overwrite it.
    service "mesos-local" do # Nope, kill it for good
      provider Chef::Provider::Service::Upstart
      supports :stop => true
      only_if do serviceAction == 'stop' end 
      action serviceAction
    end

    serviceMesos serviceAction, 'master'
    serviceMesos serviceAction, 'slave'

  when 'master'
    service "mesos-master" do # All us
      provider Chef::Provider::Service::Upstart
      supports :status => true, :start => true, :stop => true, :restart => true
      action serviceAction
    end
  when 'slave'
    service "mesos-slave" do # All us
      provider Chef::Provider::Service::Upstart
      supports :status => true, :start => true, :stop => true, :restart => true
      action serviceAction
    end    
  when 'other'
    # For safety, in-case someone installed chef over an existing install
    # by another script/app
    service "mesos" do # Not us, kill it for good
      provider Chef::Provider::Service::Upstart
      supports :status => true, :start => true, :stop => true, :restart => true
      action serviceAction
    end
  end
end

# mode:{local|master|slave|other}
def checkFile(mode='local')
  prefix = node[:mesos][:install][:prefix]
  local_prefix = node[:mesos][:install][:local_prefix]

  log "Mesos prefix is: [#{prefix}], local prefix is: [#{local_prefix}]"

  case mode
  when 'local'
    "#{local_prefix}/#{node[:mesos][:install][:local_script]}"
  when 'master'
    "#{prefix}/#{node[:mesos][:install][:master_script]}"
  when 'slave'
    "#{prefix}/#{node[:mesos][:install][:slave_script]}"
  else
    raise "Must supply 'mode' to check_file method"
  end
end

# mode:{local|master|slave|other}
def mesosExists?(mode='local')
  mesos_file = checkFile mode
  log "using file: [#{mesos_file}]"
  File.exists?(mesos_file)
end

