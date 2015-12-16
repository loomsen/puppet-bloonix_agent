# == Class: bloonix_agent
#
# Full description of class bloonix_agent here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'bloonix_agent':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class bloonix_agent (
  $package_manage                  = $bloonix_agent::params::package_manage,
  $package_name                    = $bloonix_agent::params::package_name,
  $package_ensure                  = $bloonix_agent::params::package_ensure,
  $config_bloonix_server           = $bloonix_agent::params::config_bloonix_server,
  $config_bloonix_server_port      = $bloonix_agent::params::config_bloonix_server_port,
  $config_server_mode              = $bloonix_agent::params::config_server_mode,
  $config_server_use_ssl           = $bloonix_agent::params::config_server_use_ssl,
  $config_server_ssl_verify_mode   = $bloonix_agent::params::config_server_ssl_verify,
  $config_server_ssl_ca_param      = $bloonix_agent::params::config_server_ssl_ca_param,
  $config_server_ssl_ca_file       = $bloonix_agent::params::config_server_ssl_ca_file,
  $config_agents                   = $bloonix_agent::params::config_agents,
  $config_user                     = $bloonix_agent::params::config_user,
  $config_group                    = $bloonix_agent::params::config_group,
  $config_plugins                  = $bloonix_agent::params::config_plugins,
  $config_simple_plugins           = $bloonix_agent::params::config_simple_plugins,
  $config_use_sudo                 = $bloonix_agent::params::config_use_sudo,
  $config_include                  = $bloonix_agent::params::config_include,
  $config_register_enable          = $bloonix_agent::params::config_register_enable,
  $config_register_company_id      = $bloonix_agent::params::config_register_company_id,
  $config_register_company_authkey = $bloonix_agent::params::config_register_company_authkey,
  $config_register_template_tags   = $bloonix_agent::params::config_register_template_tags,
  $config_register_description     = $bloonix_agent::params::config_register_description,
  $config_log_filename             = $bloonix_agent::params::config_log_filename,
  $config_log_filelock             = $bloonix_agent::params::config_log_filelock,
  $config_log_maxlevel             = $bloonix_agent::params::config_log_maxlevel,
  $config_log_minlevel             = $bloonix_agent::params::config_log_minlevel,
  $config_log_timeformat           = $bloonix_agent::params::config_log_timeformat,
  $config_log_message_layout       = $bloonix_agent::params::config_log_message_layout,
  $service_name                    = $bloonix_agent::params::service_name,
  $service_ensure                  = $bloonix_agent::params::service_ensure,
  $service_enable                  = $bloonix_agent::params::service_enable,

) inherits ::bloonix_agent::params {

  validate_bool($package_manage)
  validate_string($package_name)
  validate_string($package_ensure)
  validate_string($config_bloonix_server)
  validate_integer($config_bloonix_server_port)
  validate_integer($config_agents)
  validate_string($config_user)
  validate_string($config_group)
  validate_string($config_plugins)
  validate_string($config_simple_plugins)
  validate_string($config_use_sudo)
  validate_string($config_include)
  validate_absolute_path($config_log_filename)
  validate_string($config_log_maxlevel)
  validate_string($config_log_minlevel)
  validate_string($config_log_timeformat)
  validate_string($config_log_message_layout)
  validate_string($service_name)
  validate_string($service_ensure)
  validate_string($service_enable)

  # check for autoregistration
  if $config_register_enable { 
    validate_bool($config_register_enable)
    validate_integer($config_register_company_id)
    validate_string($config_register_company_authkey)
    if $config_register_template_tags { validate_string($config_register_template_tags) }
    if $config_register_description   { validate_string($config_register_description)   }
  }

  if $package_manage {
    case $::operatingsystem { /^(Debian|Ubuntu)$/: {include apt } }
    class {'::bloonix_agent::repo': } ->
    class {'::bloonix_agent::install': } ->
    class {'::bloonix_agent::config': } ~>
    class {'::bloonix_agent::service': }

    contain '::bloonix_agent::repo'
    contain '::bloonix_agent::install'
    contain '::bloonix_agent::config'
    contain '::bloonix_agent::service'
  }
}
