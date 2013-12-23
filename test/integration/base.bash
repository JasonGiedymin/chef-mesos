@test "the default file is present" {
  local file=/etc/default/mesos
  [ -e $file ]
}
