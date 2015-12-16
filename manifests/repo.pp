class bloonix_agent::repo {
  $repo = $::operatingsystem ? {
    "CentOS" => 'https://download.bloonix.de/repos/centos/$releasever/$basearch',
    "Fedora" => 'https://download.bloonix.de/repos/centos/7/$basearch',
    "Debian" => "https://download.bloonix.de/repos/debian/",
    "Ubuntu" => "https://download.bloonix.de/repos/ubuntu/",
  }

  yumrepo { 'bloonix':
    enabled  => 1,
    descr    => 'bloonix repo',
    baseurl  => "$repo",
    gpgcheck => 1,
    gpgkey   => 'https://download.bloonix.de/repos/centos/RPM-GPG-KEY-Bloonix',
  }


  case $operatingsystem { 
    /^(Debian|Ubuntu)$/: {

      $debian_requires = [ 'apt-transport-https', 'ca-certificates', 'curl' ]

      package { $debian_requires: 
        ensure => 'present',
      }

      apt::source { 'bloonix':
        location => "$repo",
        release  => "$::lsbdistcodename",
        repos    => 'main',
        key      => {
          id     => 'E0179FA04807A9155ECB96243802BAF4AC22D69E',
          source => 'https://download.bloonix.de/repos/debian/bloonix.gpg',
        },
        require => Package[$debian_requires],
      }

    }
  }

}
