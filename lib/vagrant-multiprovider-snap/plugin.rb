require 'vagrant'

module VagrantSnap
    class Plugin < Vagrant.plugin("2")


        require_relative "command/root"
        require_relative "providers/virtualbox/action"
        require_relative "providers/virtualbox/driver/base"
        require_relative "providers/virtualbox/driver/meta"

	require_relative "providers/hyperv/action"
	require_relative "providers/hyperv/driver/base"

        begin

            # Make sure the fusion plugin is installed (explicitly
            # requiring the classes we're going to extend otherwise
            # they don't get autloaded in time for us to do so)
            
            require "vagrant-vmware-fusion/action" 
            require "vagrant-vmware-fusion/driver" 

            # ...then include our overrides
            
            require_relative "providers/vmware_fusion/action"
            require_relative "providers/vmware_fusion/driver/base"

        rescue LoadError => e
            # If we can't load the fusion plugin, quietly ignore it
        end

        begin

            # Same again but for the workstation plugin

            require "vagrant-vmware-workstation/action" 
            require "vagrant-vmware-workstation/driver" 

            require_relative "providers/vmware_workstation/action"
            require_relative "providers/vmware_workstation/driver/base"

        rescue LoadError => e
            # If we can't load the workstation plugin, quietly ignore it
        end


        name "snap command"

        description <<-DESC
        This command provides snapshot features across multiple
        Vagrant providers
        DESC

        command("snap") do
            setup_i18n
            Command::Root
        end

        def self.setup_i18n
            I18n.load_path << File.expand_path("locales/en.yml", VagrantSnap.source_root)
            I18n.reload!
        end

    end
end
