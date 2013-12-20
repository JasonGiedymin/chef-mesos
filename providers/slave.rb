def whyrun_supported?
  true
end


action :create do
  sayHello
  stopMesos :other
  beginInstall :slave
end

# action :create_if_missing do

# end

# action :update do

# end



