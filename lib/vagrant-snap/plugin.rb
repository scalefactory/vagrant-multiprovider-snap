require 'vagrant'

module VagrantSnap
    class Plugin < Vagrant.plugin("2")

        name "snap command"

        description <<-DESC
        This command provides snapshot features across multiple
        Vagrant providers
        DESC

        command("snap") do
            setup_i18n
            require_relative "command/root"
            require_relative "providers/virtualbox/action"
            require_relative "providers/virtualbox/driver/base"
            Command::Root
        end

        def self.setup_i18n
            I18n.load_path << File.expand_path("locales/en.yml", VagrantSnap.source_root)
            I18n.reload!
        end

    end
end
