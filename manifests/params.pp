class bloonix_agent::params {
  $package_manage                  = true
  # Install
  $package_name                    = 'bloonix-agent'
  $package_ensure                  = 'present'
  # CONFIG
  $config_bloonix_server           = 'bloonix.flx.bn'
  $config_bloonix_server_port      = '5460'
  $config_agents                   = '4'
  $config_user                     = 'bloonix'
  $config_group                    = 'bloonix'
  $config_plugins                  = '/usr/lib/bloonix/plugins'
  $config_simple_plugins           = '/usr/local/lib/bloonix/simple-plugins,/usr/lib/bloonix/simple-plugins'
  $config_use_sudo                 = 'unset'
  $config_include                  = '/etc/bloonix/agent/conf.d'
  # Service
  $service_name                    = 'bloonix-agent'
  $service_ensure                  = 'running'
  $service_enable                  = 'true'
  # auto register
  $config_register_enable          = false
  $config_register_company_id      = '666'
  $config_register_company_authkey = 'checkBLOONIXforTHEkey' 
  $config_register_template_tags   = undef
  $config_register_description     = undef
}

