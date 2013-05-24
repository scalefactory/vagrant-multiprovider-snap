module HashiCorp

    module VagrantVMwarefusion

        module Driver

            class Fusion

                def snapshot_take
                    vmrun("snapshot", "#{vmx_path}", "vagrant-snap-#{Time.now.to_i}")
                end

                def snapshot_rollback(bootmode)
                   vmrun("revertToSnapshot", "#{vmx_path}", list_snapshots.first)
                   start
                end

                def list_snapshots
                    snapshots = []
                    vmrun("listSnapshots", "#{vmx_path}").stdout.split("\n").each do |line|
                        if line =~ /^vagrant-snap-/
                            snapshots << line
                        end
                    end
                    snapshots.sort
                end

            end

        end

    end

end
