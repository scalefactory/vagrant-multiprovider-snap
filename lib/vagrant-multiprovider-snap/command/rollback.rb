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

                    vm.action(:snapshot_rollback)

                end

                0

            end

        end

    end

end
