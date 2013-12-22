def whyrun_supported?
  true
end


action :create do
  sayHello
  serviceMesos :stop, :other
end

# action :create_if_missing do

# end

# action :update do

# end



