# encoding: UTF-8

def whyrun_supported?
  true
end

action :create do
  say_hello
  new_resource.updated_by_last_action(true)
end
