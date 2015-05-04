include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"], "check_nginx.sh") do
  source "check_nginx.sh"
  mode "755"
  action :create
end

nrpe_check "check_nginx" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_nginx.sh"
  warning_condition node['mo_monitoring_client']['plugins']['check_nginx']['warning_condition']
  critical_condition node['mo_monitoring_client']['plugins']['check_nginx']['critical_condition']
  parameters node['mo_monitoring_client']['plugins']['check_nginx']['parameters']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
