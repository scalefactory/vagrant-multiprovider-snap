require 'optparse'
require 'vagrant'

module VagrantSnap

    module Command

        class Rollback < Vagrant.plugin("2", :command)

            def execute

                options = {}
                options[:snap_name] = nil

                opts = OptionParser.new do |o|

                    o.banner    = "Usage: vagrant snap rollback [vm-name] [--name=<snapname>]"
                    o.separator ""

                    o.on("--name SNAPNAME", "Roll back to the named snapshot (defaults to last taken)") do |n|
                        options[:snap_name] = n
                    end

                end

                argv = parse_options(opts)
                return if !argv

                with_target_vms(argv) do |vm|

                    vm.action(:snapshot_rollback, :snap_name => options[:snap_name])

                end

                0

            end

        end

    end

end
