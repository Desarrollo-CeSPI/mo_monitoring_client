include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"],"check_elasticsearch") do
  source "check_elasticsearch"
  mode "755"
  action :create
end

nrpe_check "check_elasticsearch" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_elasticsearch"
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
