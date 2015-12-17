# == Class: bloonix_agent
#
# The main class. Sets up a repo, installs a package, enables and manages 
# the service, and optionally registers with a bloonix server.
#
# === Parameters
#
# Please refer to README.md for Params
#
# === Variables
#
# At the very least you will need to pass bloonix_server for the agent to know whom to talk to
#
# [*config_bloonix_server*]
#   This value will be set in the main.conf file
#
# === Examples
#
#  class { '::bloonix_agent':
#    config_bloonix_server => 'bloonix.flx.bn',
#    config_bloonix_webgui => 'http://bloonix.flx.bn',
#  }
#
# === Authors
#
# Norbert Varzariu <loomsen@gmail.com>
#
# === Copyright
#
# Copyright 2015 Norbert Varzariu
#
class bloonix_agent (
  $package_manage                  = $bloonix_agent::params::package_manage,
  $package_name                    = $bloonix_agent::params::package_name,
  $package_ensure                  = $bloonix_agent::params::package_ensure,
  $config_bloonix_webgui           = $bloonix_agent::params::config_bloonix_webgui,
  $config_bloonix_server           = $bloonix_agent::params::config_bloonix_server,
  $config_bloonix_server_port      = $bloonix_agent::params::config_bloonix_server_port,
  $config_server_mode              = $bloonix_agent::params::config_server_mode,
  $config_server_use_ssl           = $bloonix_agent::params::config_server_use_ssl,
  $config_server_ssl_verify_mode   = $bloonix_agent::params::config_server_ssl_verify_mode,
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
  $hostname_re                     = $bloonix_agent::params::hostname_re,
  $url_re                          = $bloonix_agent::params::url_re
) inherits ::bloonix_agent::params {


  validate_bool($package_manage)
  validate_string($package_name)
  validate_string($package_ensure)
  validate_re($config_bloonix_webgui, $url_re, "This does not look like a valid URL, got ${config_bloonix_webgui} - If you are sure it is valid, please check the url_re regex in params.pp")
  validate_re($config_bloonix_server, $hostname_re, "This should be a fqdn, or at least a hostname (no protocols), got ${config_bloonix_server}")
  validate_integer($config_bloonix_server_port)
  validate_bool($config_server_use_ssl)
  validate_integer($config_agents)
  validate_string($config_user)
  validate_string($config_group)
  validate_absolute_path($config_plugins)
  validate_absolute_path($config_simple_plugins)
  validate_string($config_use_sudo)
  validate_absolute_path($config_include)
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
