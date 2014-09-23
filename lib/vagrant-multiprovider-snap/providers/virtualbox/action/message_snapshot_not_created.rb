module VagrantPlugins

    module ProviderVirtualBox

        module Action

            class MessageSnapshotNotCreated

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    if env[:snap_name].nil?
                        env[:ui].info I18n.t("vagrant_snap.actions.vm.snapshot_not_created.not_created")
                    else
                        env[:ui].info(I18n.t("vagrant_snap.actions.vm.snapshot_not_created.named_not_exist",
                            :snapshot => env[:snap_name]),
                        )
                    end

                    @app.call(env)

                end

            end

        end

    end

end
