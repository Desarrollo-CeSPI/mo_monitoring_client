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
  warning_condition 85
  critical_condition 90
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end

nrpe_check "check_ifutil" do
  command "perl #{node['mo_monitoring_client']['install_directory']}/check_ifutil.pl"
  warning_condition "50M"
  critical_condition "65M"
  parameters "-i venet0"
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
  warning_condition "15%"
  critical_condition "10%"
  parameters "/"
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end

nrpe_check "check_swap" do
  command "#{node['nrpe']['plugin_dir']}/check_swap"
  warning_condition "15%"
  critical_condition "10%"
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
