def whyrun_supported?
  true
end


action :create do
  sayHello
  stopMesos :other
  beginInstall :master
end

# action :create_if_missing do

# end

# action :update do

# end

