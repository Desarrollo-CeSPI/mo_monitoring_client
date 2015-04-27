include_recipe 'mo_monitoring_client::default'

nrpe_check "check_nginx" do
  command "#{node['nrpe']['plugin_dir']}/check_procs -c 1:30 -C nginx"
  action :add
end
