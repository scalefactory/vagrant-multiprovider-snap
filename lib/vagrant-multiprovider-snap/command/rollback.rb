require 'optparse'
require 'vagrant'

module VagrantSnap

    module Command

        class Rollback < Vagrant.plugin("2", :command)

            def execute

                options = {}

                opts = OptionParser.new do |o|
                    o.banner    = "Usage: vagrant snap rollback [vm-name]"
                    o.separator ""
                end

                argv = parse_options(opts)
                return if !argv

                with_target_vms(argv) do |vm|

                    next if vm.state.id == :not_created

                    vm.action(:snapshot_rollback)

                end

                0

            end

        end

    end

end
