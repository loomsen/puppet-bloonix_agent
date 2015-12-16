class bloonix_agent::config (
  $bloonix_server         = $bloonix_agent::config_bloonix_server,
  $bloonix_server_port    = $bloonix_agent::config_bloonix_server_port,
  $server_mode            = $bloonix_agent::config_server_mode,
  $server_use_ssl         = $bloonix_agent::config_server_use_ssl,
  $server_ssl_verify_mode = $bloonix_agent::params::config_server_ssl_verify,
  $server_ssl_ca_param    = $bloonix_agent::params::config_server_ssl_ca_param,
  $server_ssl_ca_file     = $bloonix_agent::params::config_server_ssl_ca_file,
  $agents                 = $bloonix_agent::config_agents,
  $user                   = $bloonix_agent::config_user,
  $group                  = $bloonix_agent::config_group,
  $plugins                = $bloonix_agent::config_plugins,
  $simple_plugins         = $bloonix_agent::config_simple_plugins,
  $use_sudo               = $bloonix_agent::config_use_sudo,
  $config_include         = $bloonix_agent::config_include,
  $log_filename           = $bloonix_agent::config_log_filename,
  $log_filelock           = $bloonix_agent::config_log_filelock,
  $log_maxlevel           = $bloonix_agent::config_log_maxlevel,
  $log_minlevel           = $bloonix_agent::config_log_minlevel,
  $log_timeformat         = $bloonix_agent::config_log_timeformat,
  $log_message_layout     = $bloonix_agent::config_log_message_layout,
  # autoregister agent
  $register_enable        = $bloonix_agent::config_register_enable,
  $company_id             = $bloonix_agent::config_register_company_id,
  $company_authkey        = $bloonix_agent::config_register_company_authkey,
  $template_tags          = $bloonix_agent::config_register_template_tags,
  $description            = $bloonix_agent::config_register_description,

) {
  File {
    ensure  => 'present',
    owner   => 'root',
  }

  file { '/etc/bloonix/agent/main.conf':
    content => template('bloonix_agent/main.conf.erb'),
  }

  if $register_enable {
    file { '/etc/bloonix/agent/register.conf':
      content => template('bloonix_agent/register.conf.erb'),
    }
  }
}
