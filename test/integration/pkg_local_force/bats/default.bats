@test "the default file is present" {
  local file=/etc/default/mesos
  [ -e $file ]
}

@test "binary exists: mesos-local" {
  local file=/usr/local/bin/mesos-local
  [ -e $file ]
}

@test "binary exists: mesos-master" {
  local file=/usr/local/sbin/mesos-master
  [ -e $file ]
}

@test "binary exists: mesos-slave" {
  local file=/usr/local/sbin/mesos-slave
  [ -e $file ]
}

@test "service is registered: zookeeper" {
  sudo service zookeeper status
}

@test "service is registered: mesos-master" {
  sudo service mesos-master status
}

@test "service is registered: mesos-slave" {
  sudo service mesos-slave status
}

@test "service is running: zookeeper" {
  sudo initctl list | grep "zookeeper start/running"
}

@test "service is running: mesos-master" {
  sudo initctl list | grep "mesos-master start/running"
}

@test "service is running: mesos-slave" {
  sudo initctl list | grep "mesos-slave start/running"
}
