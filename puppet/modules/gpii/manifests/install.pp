class gpii::install {

  $linux_repo_dir = '/vagrant/gpii/linux'
  $linux_repo_url = 'git://github.com/GPII/linux.git'
  $universal_repo_dir = "${$linux_repo_dir}/node_modules/universal"
  $universal_repo_url = 'git://github.com/GPII/universal.git'
  $usb_listener_repo_dir = "${$linux_repo_dir}/usbDriveListener"
  $gsettings_build_dir =
  "${$linux_repo_dir}/node_modules/gsettingsBridge/nodegsettings"
  $install_dir = '/usr/local/gpii'
  $install_dir_bin = "${$install_dir}/bin"
  $state_dir = '/var/lib/gpii'

  file { ["${install_dir}",
          "${install_dir_bin}",
          "${state_dir}"]:
    ensure  => directory,
    mode    => 0755,
  }

  package { ['dkms',
             'gcc',
             'gcc-c++',
             'git',
             'glib-devel',
             'gtk3-devel']:
    ensure  => latest,
  }

  # Set vcsrepo attributes here
  VCSREPO {
    ensure   => present,
    provider => git,
  }

  vcsrepo { "${linux_repo_dir}":
    source  => $linux_repo_url,
    notify  => EXEC['build_gsettings_module'],
  }

  vcsrepo { "${universal_repo_dir}":
    source   => $universal_repo_url,
    require  => VCSREPO["${linux_repo_dir}"],
  }

  exec { 'build_gsettings_module':
    command => 'node-waf configure build',
    cwd     => $gsettings_build_dir,
  }

  define copy_file ($path = $title, $mode, $source) {
    file { "${path}":
      ensure => present,
      mode   => $mode,
      owner  => root,
      group  => root,
      source => $source,
      subscribe => VCSREPO["${linux_repo_dir}"],
    }
  }

  copy_file { "${install_dir_bin}/handleUserDeviceEvent.sh":
    mode      => 0755,
    source    => "${usb_listener_repo_dir}/bin/handleUserDeviceEvent.sh",
  }

  copy_file { "${install_dir_bin}/trigger.sh":
    mode      => 0755,
    source    => "${usb_listener_repo_dir}/bin/trigger.sh",
  }

  copy_file { '/etc/udev/rules.d/80-gpii.rules':
    mode      => 0644,
    source    => "${usb_listener_repo_dir}/80-gpii.rules",
  }
}
