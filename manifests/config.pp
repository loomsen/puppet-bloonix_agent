class bloonix_agent::config (
  $bloonix_server      = $bloonix_agent::config_bloonix_server,
  $bloonix_server_port = $bloonix_agent::config_bloonix_server_port,
  $agents              = $bloonix_agent::config_agents,
  $user                = $bloonix_agent::config_user,
  $group               = $bloonix_agent::config_group,
  $plugins             = $bloonix_agent::config_plugins,
  $simple_plugins      = $bloonix_agent::config_simple_plugins,
  $use_sudo            = $bloonix_agent::config_use_sudo,
  $config_include      = $bloonix_agent::config_include,
) {
  File {
    ensure  => 'present',
    owner   => 'root',
  }

  file { '/etc/bloonix/agent/main.conf':
    content => template('bloonix_agent/main.conf.erb'),
  }

  file { '/etc/bloonix/agent/register.conf':
    content => template('bloonix_agent/register.conf.erb'),
  }
  
}
