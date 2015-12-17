# handles the service
class bloonix_agent::service (
  $service_ensure = $bloonix_agent::service_ensure,
  $service_enable = $bloonix_agent::service_enable,
) {
  service { $bloonix_agent::service_name:
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => Package[$bloonix_agent::package_name],
  }
}
