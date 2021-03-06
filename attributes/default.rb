# Directory where custom plugins will be installed.
default["mo_monitoring_client"]["install_directory"]                                       = "/opt/nagios"

# List of required packages to be installed.
default["mo_monitoring_client"]["packages"]                                                = %w(bc liblwp-useragent-determined-perl libredis-perl)
default["mo_monitoring_client"]["packages"] << "nagios-plugins-extra" if node['platform'] == 'ubuntu'

# Plugins parameters.
default['mo_monitoring_client']['plugins']['check_mem']['warning_condition']               = 85
default['mo_monitoring_client']['plugins']['check_mem']['critical_condition']              = 90

default['mo_monitoring_client']['plugins']['check_ifutil']['warning_condition']            = "50M"
default['mo_monitoring_client']['plugins']['check_ifutil']['critical_condition']           = "65M"

default['mo_monitoring_client']['plugins']['check_disk']['warning_condition']              = "15%"
default['mo_monitoring_client']['plugins']['check_disk']['critical_condition']             = "10%"
default['mo_monitoring_client']['plugins']['check_disk']['parameters']                     = "/"

default['mo_monitoring_client']['plugins']['check_swap']['warning_condition']              = "15%"
default['mo_monitoring_client']['plugins']['check_swap']['critical_condition']             = "10%"

default['mo_monitoring_client']['plugins']['check_nginx']['warning_condition']             = 20
default['mo_monitoring_client']['plugins']['check_nginx']['critical_condition']            = 30
default['mo_monitoring_client']['plugins']['check_nginx']['parameters']                    = "-P 8090"

default['mo_monitoring_client']['fpm']['check_status']                                     = "check_phpfpm_status"
default['mo_monitoring_client']['fpm']['check_status_command']                             = "#{node['mo_monitoring_client']['fpm']['check_status']}.pl"

default['mo_monitoring_client']['plugins']['check_mysql']['slave']['warning_condition']    = 1
default['mo_monitoring_client']['plugins']['check_mysql']['slave']['critical_condition']   = 5

default['mo_monitoring_client']['plugins']['check_load']['warning_condition']              = nil
default['mo_monitoring_client']['plugins']['check_load']['critical_condition']             = nil

default['mo_monitoring_client']['plugins']['check_ssl_cert']['warning_condition']          = 90
default['mo_monitoring_client']['plugins']['check_ssl_cert']['critical_condition']         = 30
default['mo_monitoring_client']['plugins']['check_ssl_cert']['parameters']                 = "-A -H $ARG1$ -N"

default['mo_monitoring_client']['plugins']['check_io_queue']['warning_condition']          = "99999,95"
default['mo_monitoring_client']['plugins']['check_io_queue']['critical_condition']         = "99999,115"
default['mo_monitoring_client']['plugins']['check_io_queue']['parameters']                 = "-q -d sda"

default['mo_monitoring_client']['plugins']['check_io_waiting_time']['warning_condition']   = 250
default['mo_monitoring_client']['plugins']['check_io_waiting_time']['critical_condition']  = 350
default['mo_monitoring_client']['plugins']['check_io_waiting_time']['parameters']          = "-W -d sda"

default['mo_monitoring_client']['plugins']['check_dns']['parameters']                      = "-c example.com a 127.0.0.1"

default['mo_monitoring_client']['plugins']['check_smtp']['parameters']                     = "-H #{node['fqdn']} -C 'ehlo monitoring' -e '220 #{node['fqdn']}'"
