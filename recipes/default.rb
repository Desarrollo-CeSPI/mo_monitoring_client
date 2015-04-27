node.set["nrpe"]["multi_environment_monitoring"] = true
node.set["nrpe"]["server_role"] = "monitoring"

include_recipe 'nrpe::default'
