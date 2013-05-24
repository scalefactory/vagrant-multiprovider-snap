module VagrantPlugins

    module ProviderVirtualBox

        module Action

            class SnapshotTake

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    env[:machine].provider.driver.snapshot_take

                    @app.call(env)

                end

            end

        end

    end

end
