# handles package installation
class bloonix_agent::install (
  $ensure = $bloonix_agent::package_ensure,
  $bloonix_agent = $bloonix_agent::package_name,
) {
  case $::operatingsystem {
    /Debian|Ubuntu/: {
      Package { require => Apt::Source['bloonix'], }
    }
    /^(CentOS|Fedora)$/: {
      Package { require => Yumrepo['bloonix'], }
    }
    default: {}
  }

  package { $bloonix_agent:
    ensure => $ensure,
  }

}
