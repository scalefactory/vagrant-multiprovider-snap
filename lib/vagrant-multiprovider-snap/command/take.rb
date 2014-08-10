require 'optparse'
require 'vagrant'

module VagrantSnap

    module Command

        class Take < Vagrant.plugin("2", :command)

            def execute

                options = {}
                options[:snap_name] = nil

                opts = OptionParser.new do |o|

                    o.banner    = "Usage: vagrant snap take [vm-name] [--name=<snapname>]"
                    o.separator ""

                    o.on("--name SNAPNAME", "Use the given name for this snapshot") do |n|
                        options[:snap_name] = n
                    end

                end

                argv = parse_options(opts)
                return if !argv

                with_target_vms(argv) do |vm|

                    vm.action(:snapshot_take, :snap_name => options[:snap_name])

                end

                0

            end

        end

    end

end
