include_recipe 'mo_monitoring_client::default'

cookbook_file File.join(node["mo_monitoring_client"]["install_directory"],"check_redis.pl") do
  source "check_redis.pl"
  mode "755"
  action :create
end

nrpe_check "check_redis" do
  command "#{node['mo_monitoring_client']['install_directory']}/check_redis.pl"
  parameters "-H 127.0.0.1 -a 'connected_clients,blocked_clients' -w ~,~ -c ~,~ -m -M #{node["memory"]["total"].gsub('kB', '')}K -T -R"
  action :add
  notifies :restart, "service[#{node['nrpe']['service_name']}]"
end
