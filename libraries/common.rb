def packageFile
  "#{node.default.mesos.source.dir}/#{node.default.mesos.install.filename}"
end

def sayHello
  bannerLog "CHEF-MESOS v#{version}"
end


# mode:{local|master|slave|other}
def stopMesos(mode=:local)
  case mode
  when :local
    service "mesos-local" do # Nope, kill it for good
      supports :status => true
      action :stop
    end
  when :master
    service "mesos-master" do # All us
      supports :status => true
      action :stop
    end
  when :slave
    service "mesos-slave" do # All us
      supports :status => true
      action :stop
    end    
  when :other
    # For safety, in-case someone installed chef over an existing install
    # by another script/app
    service "mesos" do # Not us, kill it for good
      supports :status => true
      action :stop
    end
  end
end

# mode:{local|master|slave|other}
def checkFile(mode=:local)
  prefix = node[:mesos][:install][:prefix]

  case mode
  when :local
    "#{prefix}/#{node['mesos']['install']['master_local']}"
  when :master
    "#{prefix}/#{node['mesos']['install']['master_script']}"
  when :slave
    "#{prefix}/#{node['mesos']['install']['slave_script']}"
  else
    raise "Must supply 'mode' to check_file method"
  end
end

# mode:{local|master|slave|other}
def mesosExists?(mode=:local)
  File.exists?(checkFile mode)
end

def installMesos
  case node.mesos.install.via
  when "pkg"
    log "Installing via Package"

    remote_file 'download_file' do
      path packageFile
      source node.default.mesos.install.pkg_url
      # owner 'vagrant'
      # group 'vagrant'
      mode 00644
      action :create_if_missing
      notifies :install, "dpkg_package[mesos_deb]"
    end

  when "pkgsrc"
    # not yet ready
  when "src"
    log "Installing via Package"

    git node.mesos.source.dir do
      repository node.mesos.source.repo
      reference node.mesos.source.branch
      action :sync
      notifies :run, "bash[configure_mesos]"
    end  
  end
end

def beginInstall(mode)
  stopMesos mode

  if mesosExists? mode
    unless node.mesos.install.force
      log "Seems mesos-#{mode} already exists - nothing to do."
    else 
      bannerLog "Force installing mesos."
      installMesos
    end
  else
    converge_by("Create mesos-#{mode}...") do
      bannerLog "Installing mesos."
      installMesos
    end
  end
end
