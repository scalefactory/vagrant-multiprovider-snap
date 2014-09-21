module VagrantPlugins

    module HyperV

        module Action

            class SnapshotTake

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    env[:ui].info I18n.t("vagrant_snap.actions.vm.snapshot_take.taking")
                    env[:machine].provider.driver.snapshot_take(env[:snap_name])

                    @app.call(env)

                end

            end

        end

    end

end
