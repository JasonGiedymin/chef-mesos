def version
  "0.1.0"
end

def bannerLog(msg="CHEF-MESOS")
  Chef::Log.info "==================================="
  Chef::Log.info "          #{msg}                   "
  Chef::Log.info "==================================="
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