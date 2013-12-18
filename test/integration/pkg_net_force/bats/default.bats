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