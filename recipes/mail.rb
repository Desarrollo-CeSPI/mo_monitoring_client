include_recipe 'mo_monitoring_client::default'

nrpe_check "check_mailq" do
  command "#{node['nrpe']['plugin_dir']}/check_mailq"
  warning_condition 10
  critical_condition 15
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
