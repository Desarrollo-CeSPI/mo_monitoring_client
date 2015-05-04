# Directory where custom plugins will be installed.
default["mo_monitoring_client"]["install_directory"]                               = "/opt/nagios"

# List of required packages to be installed.
default["mo_monitoring_client"]["packages"]                                        = %w(bc liblwp-useragent-determined-perl)
default["mo_monitoring_client"]["packages"] << "nagios-plugins-extra" if node['platform'] == 'ubuntu'

# Plugins parameters.
default['mo_monitoring_client']['plugins']['check_mem']['warning_condition']       = 85
default['mo_monitoring_client']['plugins']['check_mem']['critical_condition']      = 90

default['mo_monitoring_client']['plugins']['check_ifutil']['warning_condition']    = "50M"
default['mo_monitoring_client']['plugins']['check_ifutil']['critical_condition']   = "65M"
default['mo_monitoring_client']['plugins']['check_ifutil']['parameters']           = "-i venet0"

default['mo_monitoring_client']['plugins']['check_disk']['warning_condition']      = "15%"
default['mo_monitoring_client']['plugins']['check_disk']['critical_condition']     = "10%"
default['mo_monitoring_client']['plugins']['check_disk']['parameters']             = "/"

default['mo_monitoring_client']['plugins']['check_swap']['warning_condition']      = "15%"
default['mo_monitoring_client']['plugins']['check_swap']['critical_condition']     = "10%"

default['mo_monitoring_client']['plugins']['check_nginx']['warning_condition']     = 10
default['mo_monitoring_client']['plugins']['check_nginx']['critical_condition']    = 20
default['mo_monitoring_client']['plugins']['check_nginx']['parameters']            = "-P 8090"

default['mo_monitoring_client']['fpm']['check_status'] = 'check_phpfpm_status'
default['mo_monitoring_client']['fpm']['check_status_command'] = "#{node['mo_monitoring_client']['fpm']['check_status']}.pl"
