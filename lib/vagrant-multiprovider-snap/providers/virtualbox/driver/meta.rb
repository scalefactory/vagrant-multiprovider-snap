module VagrantPlugins

    module ProviderVirtualBox

        module Driver

            class Meta

                def_delegators :@driver, :snapshot_take,
                        :snapshot_delete,
                        :snapshot_rollback,
                        :snapshot_list,
                        :has_snapshot?

            end

        end

    end

end
