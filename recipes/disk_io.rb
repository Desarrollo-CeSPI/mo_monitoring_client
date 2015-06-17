include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"],"check_iostat") do
  source "check_iostat"
  mode "755"
  action :create
end

nrpe_check "check_io_queue" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_iostat"
  warning_condition node['mo_monitoring_client']['plugins']['check_io_queue']['warning_condition']
  critical_condition node['mo_monitoring_client']['plugins']['check_io_queue']['critical_condition']
  parameters node['mo_monitoring_client']['plugins']['check_io_queue']['parameters']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end

nrpe_check "check_io_waiting_time" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_iostat"
  warning_condition node['mo_monitoring_client']['plugins']['check_io_waiting_time']['warning_condition']
  critical_condition node['mo_monitoring_client']['plugins']['check_io_waiting_time']['critical_condition']
  parameters node['mo_monitoring_client']['plugins']['check_io_waiting_time']['parameters']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
