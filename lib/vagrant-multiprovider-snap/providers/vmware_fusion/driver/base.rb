module HashiCorp

    module VagrantVMwarefusion

        module Driver

            class Fusion

                def snapshot_take(name)
                    vmrun("snapshot", "#{vmx_path}", name || "vagrant-snap-#{Time.now.to_i}")
                end

                def snapshot_rollback(bootmode, name)
                    vmrun("revertToSnapshot", "#{vmx_path}", name || snapshot_list.last)
                    start
                end

                def snapshot_list
                    snapshots = []
                    vmrun("listSnapshots", "#{vmx_path}").stdout.split("\n").each do |line|
                        if line !~ /Total snapshot/
                            snapshots << line
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
