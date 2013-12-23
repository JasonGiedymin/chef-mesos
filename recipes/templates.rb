# Templates


template "/etc/default/mesos" do
  source "mesos.erb"
  mode 0664
  owner "root"
  group "root"
  variables({
     :log_location => node[:mesos][:conf][:log_location],
     :ulimit => node[:mesos][:conf][:ulimit],
     :zookeepers => node[:mesos][:conf][:zookeepers],
     :masters => node[:mesos][:conf][:masters],
     :options => node[:mesos][:conf][:options]
  })
end


template "/etc/init/mesos-master.conf" do
  source "mesos-master.erb"
  mode 0664
  owner "root"
  group "root"
  variables({
     :log_location => node[:mesos][:conf][:log_location],
     :ulimit => node[:mesos][:conf][:ulimit],
     :zookeepers => node[:mesos][:conf][:zookeepers],
     :masters => node[:mesos][:conf][:masters],
     :options => node[:mesos][:conf][:options]
  })
  only_if do ![:master, :local].find{ |x| x.to_s == node[:mesos][:install][:mode] }.nil? end
end


template "/etc/init/mesos-slave.conf" do
  source "mesos-slave.erb"
  mode 0664
  owner "root"
  group "root"
  variables({
     :log_location => node[:mesos][:conf][:log_location],
     :ulimit => node[:mesos][:conf][:ulimit],
     :zookeepers => node[:mesos][:conf][:zookeepers],
     :masters => node[:mesos][:conf][:masters],
     :options => node[:mesos][:conf][:options]
  })
  only_if do ![:slave, :local].find{ |x| x.to_s == node[:mesos][:install][:mode] }.nil? end
end

bannerLog node[:mesos][:install][:mode]
bannerLog ![:master, :local].find{ |x| x.to_s == node[:mesos][:install][:mode] }.nil?
