# set up the bloonix repo
class bloonix_agent::repo {
  $repo = $::operatingsystem ? {
    'CentOS' => 'https://download.bloonix.de/repos/centos/$releasever/$basearch',
    'Fedora' => 'https://download.bloonix.de/repos/centos/7/$basearch',
    'Debian' => 'https://download.bloonix.de/repos/debian/',
    'Ubuntu' => 'https://download.bloonix.de/repos/ubuntu/',
    default  => undef,
  }


  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $debian_requires = [ 'apt-transport-https', 'ca-certificates', 'curl' ]
      package { $debian_requires:
        ensure => 'present',
      }
      apt::source { 'bloonix':
        location => $repo,
        release  => $::lsbdistcodename,
        repos    => 'main',
        key      => {
          id     => '31A86A255B0E516B0C49AE661CD8BB07F120EC73',
          source => 'https://download.bloonix.de/repos/debian/bloonix.gpg',
        },
        require  => Package[$debian_requires],
      }
    }
    /^(RedHat|CentOS|Fedora)$/: {
      yumrepo { 'bloonix':
        enabled  => 1,
        descr    => 'bloonix repo',
        baseurl  => $repo,
        gpgcheck => 1,
        gpgkey   => 'https://download.bloonix.de/repos/centos/RPM-GPG-KEY-Bloonix',
      }
    }
    default: {}
  }
}
