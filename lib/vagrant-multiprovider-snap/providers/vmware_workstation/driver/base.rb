module HashiCorp

    module VagrantVMwareworkstation

        module Driver

            class Base

                def snapshot_take(name)
                    vmrun("snapshot", "#{vmx_path}", name || "vagrant-snap-#{Time.now.to_i}")
                end

                def snapshot_delete(name)
                    vmrun("deleteSnapshot", "#{vmx_path}", name)
                end

                def snapshot_rollback(bootmode, name)
                   vmrun("revertToSnapshot", "#{vmx_path}", name || snapshot_list.last)
                   start(bootmode)
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

                def has_snapshot?(name)
                    if name.nil?
                        return true unless snapshot_list.empty?
                    else
                        return true if snapshot_list.include? "#{name}"
                    end
                end

            end

        end

    end

end
