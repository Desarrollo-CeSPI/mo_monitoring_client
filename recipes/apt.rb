nrpe_check "check_apt" do
  command "#{node['nrpe']['plugin_dir']}/check_apt"
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
