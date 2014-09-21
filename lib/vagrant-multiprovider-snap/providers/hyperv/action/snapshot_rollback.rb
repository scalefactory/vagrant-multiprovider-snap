module VagrantPlugins

    module HyperV

        module Action

            class SnapshotRollback

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    env[:ui].info I18n.t("vagrant_snap.actions.vm.snapshot_rollback.rolling_back")

                    env[:machine].provider.driver.snapshot_rollback(env[:snap_name])

                    @app.call(env)

                end

            end

        end

    end

end
