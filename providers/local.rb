def whyrun_supported?
  true
end


action :create do
  sayHello
  serviceMesos :stop, :other
  serviceMesos :stop, :local
end

# action :create_if_missing do

# end

# action :update do

# end



