module VagrantPlugins

    module ProviderVirtualBox

        module Driver

            class Base

                def snapshot_take
                    execute("snapshot", @uuid, "take", "vagrant-snap-#{Time.now.to_i}", "--pause")
                end

                def snapshot_rollback(bootmode)
                    # don't try to power off if we're already off
                    unless [:poweroff, :aborted].include?(read_state)
                        halt
                        sleep 2 # race condition on locked VMs otherwise?
                    end
                    execute("snapshot",  @uuid, "restore", snapshot_list.first)
                    start(bootmode)
                end

                def snapshot_list
                    info = execute("showvminfo", @uuid, "--machinereadable")
                    snapshots = []
                    info.split("\n").each do |line|
                        if line =~ /^SnapshotName="(vagrant-snap-.+?)"$/
                            snapshots << $1.to_s
                        end
                    end
                    snapshots
                end

                def has_snapshot?
                    snapshot_list.length > 0
                end

            end

        end

    end

end
