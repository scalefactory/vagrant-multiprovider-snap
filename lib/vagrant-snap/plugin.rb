require 'vagrant'

module VagrantSnap
    class Plugin < Vagrant.plugin("2")

        require_relative "command/root"
        require_relative "providers/virtualbox/action"
        require_relative "providers/virtualbox/driver/base"
        require_relative "providers/vmware_fusion/action"
        require_relative "providers/vmware_fusion/driver/base"

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
