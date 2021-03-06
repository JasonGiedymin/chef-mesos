# encoding: UTF-8

zk_def = 'zk://localhost:2181/mesos'

# List of all actions supported by the provider
actions :create, :create_if_missing, :update

# Make create the default action
default_action :create

# Required attributes
attribute :name, kind_of: String, name_attribute: true
attribute :zookeeper, kind_of: String, required: true, default: zk_def
attribute :zookeeper_masters, kind_of: String, required: true, default: zk_def
attribute :logs, kind_of: String, default: '/var/log/mesos'
attribute :ulimit, kind_of: String, default: '-n 8192'
attribute :opts, kind_of: String, default: ''

# Optional attributes
attribute :comment, kind_of: String

attr_accessor :exists

def initialize(name, run_context = nil)
  super
  @action = :create
end
