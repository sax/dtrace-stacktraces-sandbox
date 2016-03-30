# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

Vagrant.configure('2') do |config|
  config.vm.provider 'virtualbox' do |v|
    v.memory = 8192
    #v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
  end

  config.vm.box = 'livinginthepast/smartos-base64'
  #config.vm.network "public_network"
  #config.vm.network "private_network", ip: '10.0.0.10'
  #config.vm.network "private_network", type: 'dhcp'
  #config.vm.synced_folder ".", "/vagrant", type: "rsync", group: 'other'

  config.ssh.insert_key = false
  config.vm.communicator = 'smartos'
  config.global_zone.platform_image = 'latest'

  config.zone.image = '842e6fa6-6e9b-11e5-8402-1b490459e334'
  config.zone.name = 'ruby-dtrace-sandbox'
  config.zone.brand = 'joyent'
  config.zone.memory = 7168
  config.zone.disk_size = 5

  config.vm.synced_folder '.', '/vagrant/dtrace-stacktrace-sandbox', type: 'rsync'
  config.vm.synced_folder '../dtrace-stacktraces', '/vagrant/dtrace-stacktraces', type: 'rsync'
end

