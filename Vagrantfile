# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done here. The most common configuration
# options are documented and commented below. For a complete reference,
# please see the online documentation at vagrantup.com.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "apricot"
  config.vm.box_url = "http://vagrant.segfault.me/apricot.box"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.ssh.forward_agent = true

  config.vm.provision :puppet do |puppet|
    puppet.options = "--verbose"
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "apricot.pp"
  end
end
