@test "the slave config is present" {
  local file=/etc/init/mesos-slave.conf
  [ -e $file ]
}

