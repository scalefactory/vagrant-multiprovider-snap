module HashiCorp

    module VagrantVMwareworkstation

        module Action

            class SnapshotRollback

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    # Snapshot rollback involves powering off and on the VM, so we need to find the gui
                    # state ... however, the start() method in VagrantVMwarefusion.Driver.Fusion takes a
                    # bool, not a string, so setting this to "gui" or "nogui" will therefore always start
                    # in gui mode. Setting this to a bool instead

                    boot_mode = env[:machine].provider_config.gui

                    if env[:snap_name].nil?
                        env[:snap_name] = env[:machine].provider.driver.snapshot_list.last
                        env[:ui].info I18n.t("vagrant_snap.actions.vm.snapshot_rollback.rolling_back")
                    else
                        env[:ui].info(I18n.t("vagrant_snap.actions.vm.snapshot_rollback.rolling_back_named",
                            :snapshot => env[:snap_name]),
                        )
                    end

                    env[:machine].provider.driver.snapshot_rollback(boot_mode,env[:snap_name])

                    @app.call(env)

                end

            end

        end

    end

end
