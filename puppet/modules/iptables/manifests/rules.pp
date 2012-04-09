class iptables::rules {

  file { '/etc/sysconfig/iptables':
    owner => root,
    group => root,
    mode => 0400,
    source => 'puppet:///modules/iptables/iptables',
  }

  service { 'iptables':
    provider  => systemd,
    subscribe => File['/etc/sysconfig/iptables'],
  }
}
