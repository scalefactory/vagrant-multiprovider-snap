module HashiCorp

    module VagrantVMwarefusion

        module Driver

            class Fusion

                def snapshot_take
                    vmrun("snapshot", "#{vmx_path}", "vagrant-snap-#{Time.now.to_i}")
                end

                def snapshot_rollback(bootmode)
                   vmrun("revertToSnapshot", "#{vmx_path}", snapshot_list.last)
                   start
                end

                def snapshot_list
                    snapshots = []
                    vmrun("listSnapshots", "#{vmx_path}").stdout.split("\n").each do |line|
                        if line =~ /^vagrant-snap-/
                            snapshots << line
                        end
                    end
                    snapshots.sort
                end

                def has_snapshot?
                    snapshot_list.length > 0
                end

            end

        end

    end

end
