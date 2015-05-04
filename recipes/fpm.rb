include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"], node['mo_monitoring_client']['fpm']['check_status_command']) do
  source node['mo_monitoring_client']['fpm']['check_status_command']
  mode "755"
  action :create
end
