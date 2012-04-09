Vagrant::Config.run do |config|

  config.vm.box = 'Fedora-16-i386'
  config.vm.boot_mode = :gui
  config.vm.forward_port 8081, 8081

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet'
    puppet.module_path = 'puppet/modules'
    puppet.manifest_file = 'init.pp'
    puppet.options = '--verbose'
  end

  config.vm.customize ['modifyvm', :id, '--memory', '2048']
  config.vm.customize ['modifyvm', :id, '--cpus', '2']
  config.vm.customize ['modifyvm', :id, '--vram', '16']
  config.vm.customize ['modifyvm', :id, '--accelerate3d', 'on']

  # This gets rid of the dbus-launch "Autolaunch error: X11 initialization failed" errors
  config.ssh.forward_x11 = true
end
