# encoding: UTF-8

# Templates

mode = node['mesos']['install']['mode']

template '/etc/default/mesos' do
  source 'mesos.erb'
  mode 0664
  owner 'root'
  group 'root'
  variables(
     'log_location' => node['mesos']['conf']['log_location'],
     'ulimit' => node['mesos']['conf']['ulimit'],
     'zookeepers' => node['mesos']['conf']['zookeepers'],
     'masters' => node['mesos']['conf']['masters'],
     'options' => node['mesos']['conf']['options']
  )
end

template '/etc/init/mesos-master.conf' do
  source 'mesos-master.erb'
  mode 0664
  owner 'root'
  group 'root'
  variables(
     'log_location' => node['mesos']['conf']['log_location'],
     'ulimit' => node['mesos']['conf']['ulimit'],
     'zookeepers' => node['mesos']['conf']['zookeepers'],
     'masters' => node['mesos']['conf']['masters'],
     'options' => node['mesos']['conf']['options']
  )
  only_if { ![:master, :local].find { |x| x.to_s == mode }.nil? }
end

template '/etc/init/mesos-slave.conf' do
  source 'mesos-slave.erb'
  mode 0664
  owner 'root'
  group 'root'
  variables(
     'log_location' => node['mesos']['conf']['log_location'],
     'ulimit' => node['mesos']['conf']['ulimit'],
     'zookeepers' => node['mesos']['conf']['zookeepers'],
     'masters' => node['mesos']['conf']['masters'],
     'options' => node['mesos']['conf']['options']
  )
  only_if { ![:slave, :local].find { |x| x.to_s == mode }.nil? }
end
