require 'vagrant'

module VagrantSnap
    class Plugin < Vagrant.plugin("2")

        name "snap command"

        description <<-DESC
        This command provides snapshot features across multiple
        Vagrant providers
        DESC

        command("snap") do
            require_relative "command/root"
            require_relative "providers/virtualbox/action"
            require_relative "providers/virtualbox/driver/base"
            Command::Root
        end

    end
end
