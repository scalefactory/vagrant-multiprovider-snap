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

                    unless options[:snap_name].nil?

                        snaps = vm.provider.driver.snapshot_list

                        if snaps.include? /#{options[:snap_name]}/
                            vm.action(:snapshot_rollback, :snap_name => options[:snap_name])
                        else
                            @env.ui.info(I18n.t("vagrant_snap.commands.rollback.output",
                                                :snapshot => options[:snap_name]),
                                        :prefix => false)
                        end

                    else
                        vm.action(:snapshot_rollback, :snap_name => options[:snap_name])
                    end

                end

                0

            end

        end

    end

end
