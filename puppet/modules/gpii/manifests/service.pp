class gpii::service {

  require gpii::install

  file { '/lib/systemd/system/gpii-node.service':
    ensure => present,
    source => 'puppet:///modules/gpii/gpii-node.service',
    owner  => root,
    group  => root,
    mode   => 0644,
    notify => Service['gpii-node'],
  }

  service { 'gpii-node':
    ensure => running,
    enable => true,
  }
}
