def whyrun_supported?
  true
end


action :create do
  sayHello
  stopMesos :other
  beginInstall :local
end

action :create_if_missing do

end

action :update do

end


