# encoding: UTF-8

def install_mode
  node['mesos']['install']['mode']
end

def package_file(mode)
  case mode
  when 'local'
    node['mesos']['install']['pkg_local']
  when 'remote'
    "#{node['mesos']['source']['dir']}/#{node['mesos']['install']['filename']}"
  end
end

def package_file(mode)
  case mode
  when 'local'
    node['mesos']['install']['pkg_local']
  when 'remote'
    "#{node['mesos']['source']['dir']}/#{node['mesos']['install']['filename']}"
  end
end

def say_hello
  banner_log "CHEF-MESOS v#{version}"
end

def prefixed_node(leaf)
  "#{node['mesos']['install']['prefix']}/#{node['mesos']['install'][leaf]}"
end

def check_file(mode = 'local')
  local_prefix = node['mesos']['install']['local_prefix']
  local_script = node['mesos']['install']['local_script']

  case mode
  when 'local'
    "#{local_prefix}/#{local_script}"
  when 'master', 'slave'
    prefixed_node("#{mode}_script")
  else
    fail 'Must supply mode to check_file method'
  end
end

# mode:{local|master|slave|other}
def mesos_exists?(mode = 'local')
  mesos_file = check_file(mode)
  log "using file: [#{mesos_file}]"
  File.exists?(mesos_file)
end
