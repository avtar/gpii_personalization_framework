class nodejs::install {

  package { ['nodejs',
             'nodejs-devel',
             'nodejs-waf',
             'nodejs-doc',
             'nodejs-debuginfo']:
    ensure  => latest,
    notify  => File['/usr/bin/node'],
  }

  file { '/usr/bin/node':
    ensure => link,
    target => '/usr/bin/nodejs',
  }
}
