include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"],"check_mem.sh") do
  source "check_mem.sh"
  mode "755"
  action :create
end

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"],"check_ifutil.pl") do
  source "check_ifutil.pl"
  mode "755"
  action :create
end

nrpe_check "check_mem" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_mem.sh"
  warning_condition node['mo_monitoring_client']['plugins']['check_mem']['warning_condition']
  critical_condition node['mo_monitoring_client']['plugins']['check_mem']['critical_condition']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end

nrpe_check "check_ifutil" do
  command "perl #{node['mo_monitoring_client']['install_directory']}/check_ifutil.pl"
  warning_condition node['mo_monitoring_client']['plugins']['check_ifutil']['warning_condition']
  critical_condition node['mo_monitoring_client']['plugins']['check_ifutil']['critical_condition']
  parameters node['mo_monitoring_client']['plugins']['check_ifutil']['parameters']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end

nrpe_check "check_load" do
  command "#{node['nrpe']['plugin_dir']}/check_load"
  warning_condition (node["cpu"]["total"].to_i*0.9).to_s
  critical_condition node["cpu"]["total"]
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end

nrpe_check "check_disk" do
  command "#{node['nrpe']['plugin_dir']}/check_disk"
  warning_condition node['mo_monitoring_client']['plugins']['check_disk']['warning_condition']
  critical_condition node['mo_monitoring_client']['plugins']['check_disk']['critical_condition']
  parameters node['mo_monitoring_client']['plugins']['check_disk']['parameters']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end

nrpe_check "check_swap" do
  command "#{node['nrpe']['plugin_dir']}/check_swap"
  warning_condition node['mo_monitoring_client']['plugins']['check_swap']['warning_condition']
  critical_condition node['mo_monitoring_client']['plugins']['check_swap']['critical_condition']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
