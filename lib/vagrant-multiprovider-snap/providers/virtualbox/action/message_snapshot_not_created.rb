module VagrantPlugins

    module ProviderVirtualBox

        module Action

            class MessageSnapshotNotCreated

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    env[:ui].info I18n.t("vagrant_snap.actions.vm.snapshot_not_created")

                    @app.call(env)

                end

            end

        end

    end

end
