def whyrun_supported?
  true
end

action :create do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
    testme
  else
    converge_by("Create #{ @new_resource }") do
      testme
    end
  end
end

action :create_if_missing do

end

action :update do

end

def testme
  Chef::Log.info "==================================="
  Chef::Log.info "              TESTING              "
  Chef::Log.info "==================================="
end