include_recipe 'mo_monitoring_client::default'

if node['mysql'] and node['mysql']['server_root_password']
  nrpe_check "check_mysql_master" do
    command "#{node['nrpe']['plugin_dir']}/check_mysql"
    parameters "-H 127.0.0.1 -u root -p #{node['mysql']['server_root_password']}"
    action :add
    notifies :restart, "service[#{node['nrpe']['service_name']}]"
  end

  nrpe_check "check_mysql_slave" do
    command "#{node['nrpe']['plugin_dir']}/check_mysql"
    warning_condition node['mo_monitoring_client']['plugins']['check_mysql']['slave']['warning_condition']
    critical_condition node['mo_monitoring_client']['plugins']['check_mysql']['slave']['critical_condition']
    parameters "-H 127.0.0.1 -u root -p #{node['mysql']['server_root_password']} -S"
    action :add
    notifies :restart, "service[#{node['nrpe']['service_name']}]"
  end
end
