include_recipe 'mo_monitoring_client::default'

nrpe_check "check_smtp" do
  command "#{node['nrpe']['plugin_dir']}/check_smtp"
  parameters node['mo_monitoring_client']['plugins']['check_smtp']['parameters']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
