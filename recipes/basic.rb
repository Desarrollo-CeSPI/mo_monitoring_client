include_recipe 'mo_monitoring_client::default'

nrpe_check "check_load" do
  command "#{node['nrpe']['plugin_dir']}/check_load"
  warning_condition (node["cpu"]["total"].to_i*0.9).to_s
  critical_condition node["cpu"]["total"]
  action :add
end

nrpe_check "check_disk" do
  command "#{node['nrpe']['plugin_dir']}/check_disk"
  warning_condition "15%"
  critical_condition "10%"
  parameters "/"
  action :add
end

nrpe_check "check_swap" do
  command "#{node['nrpe']['plugin_dir']}/check_swap"
  warning_condition "15%"
  critical_condition "10%"
  action :add
end
