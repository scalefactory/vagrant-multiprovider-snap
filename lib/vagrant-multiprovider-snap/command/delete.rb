require 'optparse'
require 'vagrant'

module VagrantSnap

    module Command

        class Delete < Vagrant.plugin("2", :command)

            def execute

                options = {}
                options[:snap_name] = nil

                opts = OptionParser.new do |o|

                    o.banner    = "Usage: vagrant snap delete [vm-name] --name=<snapname>"
                    o.separator ""

                    o.on("--name SNAPNAME", "Snapshot to delete - mandatory option") do |n|
                        options[:snap_name] = n
                    end

                end

                begin
                    argv = parse_options(opts)
                    return if !argv
                    if options[:snap_name].nil?
                        puts "Missing option: <snapname>"
                        puts opts
                        return false
                    end
                rescue OptionParser::InvalidOption, OptionParser::MissingArgument
                    puts $!.to_s
                    puts opts
                    return false
                end

                with_target_vms(argv) do |vm|

                    snaps = vm.provider.driver.snapshot_list

                    if snaps.include? "#{options[:snap_name]}"
                        vm.action(:snapshot_delete, :snap_name => options[:snap_name])
                    else
                        @env.ui.info(I18n.t("vagrant_snap.commands.delete.output",
                                            :snapshot => options[:snap_name]),
                                    :prefix => false)
                    end

                end

                0

            end

        end

    end

end
