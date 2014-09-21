require "vagrant-multiprovider-snap" 

Vagrant.configure("2") do |config|

    config.vm.box     = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    config.vm.provider :vmware_fusion do |fusion,override|
        override.vm.box     = "precise64_vmware_fusion"
        override.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"
    end

    config.vm.provider :hyperv do |hyperv,override|
        override.vm.box = "hashicorp/precise64"
    end

end
