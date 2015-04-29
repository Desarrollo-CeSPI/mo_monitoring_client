include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"],"check_phpfpm_status.pl") do
  source "check_phpfpm_status.pl"
  mode "755"
  action :create
end
