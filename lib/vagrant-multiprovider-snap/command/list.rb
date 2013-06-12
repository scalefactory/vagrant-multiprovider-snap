require 'optparse'
require 'vagrant'

module VagrantSnap

    module Command

        class List < Vagrant.plugin("2", :command)

            def execute

                options = {}

                opts = OptionParser.new do |o|
                    o.banner    = "Usage: vagrant snap list [vm-name]"
                    o.separator ""
                end

                argv = parse_options(opts)
                return if !argv

                results = []

                with_target_vms(argv) do |machine|

                    results << "#{machine.name.to_s}"

                    snaps = machine.provider.driver.snapshot_list

                    if snaps.length == 0
                        results << "  (none)"
                    else
                        snaps.each do |snap|
                            results << "  + #{snap}"
                        end
                    end

                    results << "\n"

                end

                @env.ui.info(I18n.t("vagrant_snap.commands.list.output",
                                    :snapshots => results.join("\n")),
                             :prefix => false)

                0

            end

        end

    end

end
