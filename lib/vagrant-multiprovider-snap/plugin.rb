require 'vagrant'

module VagrantSnap
    class Plugin < Vagrant.plugin("2")


        require_relative "command/root"
        require_relative "providers/virtualbox/action"
        require_relative "providers/virtualbox/driver/base"
        require_relative "providers/virtualbox/driver/meta"

        begin

            # Make sure the fusion plugin is installed, then
            # include the fusion providers.
            
            Vagrant.require_plugin("vagrant-vmware-fusion")
            require_relative "providers/vmware_fusion/action"
            require_relative "providers/vmware_fusion/driver/base"

        rescue Vagrant::Errors::PluginLoadError => e

            # If we can't load the fusion plugin, quietly ignore it
            # I'd like to log an info level message here, but I don't
            # think I can get at a ui object in this scope.

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
