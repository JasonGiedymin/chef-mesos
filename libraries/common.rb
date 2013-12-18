def packageFile(mode)
  case mode
  when :local
    node.default.mesos.install.pkg_local
  when :remote
    "#{node.default.mesos.source.dir}/#{node.default.mesos.install.filename}"
  end
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
  local_prefix = node[:mesos][:install][:local_prefix]

  log "Mesos prefix is: [#{prefix}], local prefix is: [#{local_prefix}]"

  case mode
  when :local
    "#{local_prefix}/#{node[:mesos][:install][:local_script]}"
  when :master
    "#{prefix}/#{node[:mesos][:install][:master_script]}"
  when :slave
    "#{prefix}/#{node[:mesos][:install][:slave_script]}"
  else
    raise "Must supply 'mode' to check_file method"
  end
end

# mode:{local|master|slave|other}
def mesosExists?(mode=:local)
  mesos_file = checkFile mode
  log "using file: [#{mesos_file}]"
  File.exists?(mesos_file)
end

def installPkg
  log "Installing via remote package..."

  remote_file 'download_file' do
    path packageFile :remote
    source node.default.mesos.install.pkg_url
    # owner 'vagrant'
    # group 'vagrant'
    # mode 00644
    action :create_if_missing
    notifies :install, "dpkg_package[mesos_deb]"
  end
end

def installMesos
  mode = node.mesos.install.via

  case mode
  when "pkg"
    installPkg
  when "pkg_local"
    log "Installing via local package..."

    if File.exists? packageFile :local
      log "Local package file exists, using it for install..."

      dpkg_package "mesos_deb_local" do
        action :install
        only_if do File.exists? packageFile :local end
      end
    else
      # log "Resolve set to: #{node.mesos.install.resolve}"

      if node.mesos.install.resolve
        log "Resolve set, will try to install with remote package..."
        installPkg
      else
        fatal "Could not find package file, resolve not set, nothing to do. Raising exception."
      end
    end

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
  # TODO: move this into local.rb
  if mesosExists? mode
    if node.mesos.install.force
      bannerLog "Force installing mesos."
      installMesos
    else
      log "Seems mesos-#{mode} already exists, not forcing - nothing to do."
    end
  else
    converge_by("Create mesos-#{mode}...") do
      bannerLog "Installing mesos."
      installMesos
    end
  end
end
