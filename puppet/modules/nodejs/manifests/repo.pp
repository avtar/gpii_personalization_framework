class nodejs::repo {

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-tchol':
    owner => root,
    group => root,
    mode => 0444,
    source => 'puppet:///modules/nodejs/RPM-GPG-KEY-tchol',
  }

  yumrepo { 'tchol':
    baseurl => 'http://nodejs.tchol.org/stable/f16/i386/',
    enabled => 1,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-tchol',
    require => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-tchol'],
  }
}
