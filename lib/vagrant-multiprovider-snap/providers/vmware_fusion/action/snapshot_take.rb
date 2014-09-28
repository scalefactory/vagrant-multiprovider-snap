module HashiCorp

    module VagrantVMwarefusion

        module Action

            class SnapshotTake

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    if env[:snap_name].nil?
                        env[:ui].info I18n.t("vagrant_snap.actions.vm.snapshot_take.taking")
                    else
                        env[:ui].info(I18n.t("vagrant_snap.actions.vm.snapshot_take.taking_named",
                            :snapshot => env[:snap_name]),
                        )
                    end

                    env[:machine].provider.driver.snapshot_take(env[:snap_name])

                    @app.call(env)

                end

            end

        end

    end

end
