# encoding: UTF-8

def version
  '0.1.2'
end

def banner_log(msg = 'CHEF-MESOS')
  Chef::Log.info '==================================='
  Chef::Log.info "          #{msg}                   "
  Chef::Log.info '==================================='
end

def log(msg)
  Chef::Log.info msg
end

def warn(msg)
  Chef::Log.warn msg
end

def fatal(msg)
  Chef::Application.fatal! msg
end
