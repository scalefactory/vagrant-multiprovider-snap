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
                    execute("snapshot",  @uuid, "restorecurrent")
                    start(bootmode)

                end

            end

        end

    end

end
