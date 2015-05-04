node.set["nrpe"]["multi_environment_monitoring"] = true
node.set["nrpe"]["server_role"] = "monitoring"

include_recipe 'nrpe::default'

directory node["mo_monitoring_client"]["install_directory"]

node["mo_monitoring_client"]["packages"].each do |p|
    package p
end
