include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"], "check_ssl_cert") do
  source "check_ssl_cert"
  mode "755"
  action :create
end

nrpe_check "check_ssl_cert" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_ssl_cert"
  warning_condition node['mo_monitoring_client']['plugins']['check_ssl_cert']['warning_condition']
  critical_condition node['mo_monitoring_client']['plugins']['check_ssl_cert']['critical_condition']
  parameters node['mo_monitoring_client']['plugins']['check_ssl_cert']['parameters']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
