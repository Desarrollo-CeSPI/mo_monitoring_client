include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"], "check_dns.sh") do
  source "check_dns.sh"
  mode "755"
  action :create
end

nrpe_check "check_dns" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_dns.sh"
  parameters node['mo_monitoring_client']['plugins']['check_dns']['parameters']
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
