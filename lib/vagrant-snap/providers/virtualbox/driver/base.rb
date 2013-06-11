module VagrantPlugins

    module ProviderVirtualBox

        module Driver

            class Base

                def snapshot_take
                    execute("snapshot", @uuid, "take", "vagrant-snap-#{Time.now.to_i}", "--pause")
                end

                def snapshot_rollback(bootmode)
                    halt
                    sleep 2 # race condition on locked VMs otherwise?
                    execute("snapshot",  @uuid, "restore", snapshot_list.first)
                    start(bootmode)
                end

                def snapshot_list
                    # XXX blows up if no snapshots on the VM - how to prevent this?
                    info = execute("snapshot", @uuid, "list", "--machinereadable")
                    snapshots = []
                    info.split("\n").each do |line|
                        if line =~ /^SnapshotName="(.+?)"$/
                            snapshots << $1.to_s
                        end
                    end
                    snapshots
                end

            end

        end

    end

end
