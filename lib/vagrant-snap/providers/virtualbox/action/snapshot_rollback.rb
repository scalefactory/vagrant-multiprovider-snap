module VagrantPlugins

    module ProviderVirtualBox

        module Action

            class SnapshotRollback

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    boot_mode = env[:machine].provider_config.gui ? "gui" : "headless"
                    env[:machine].provider.driver.snapshot_rollback(boot_mode)

                    @app.call(env)

                end

            end

        end

    end

end
