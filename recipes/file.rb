include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"],"check_file.pl") do
  source "check_file.pl"
  mode "755"
  action :create
end

nrpe_check "check_file" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_file.pl"
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
