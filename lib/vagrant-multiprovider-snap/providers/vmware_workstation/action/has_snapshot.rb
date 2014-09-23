module HashiCorp

    module VagrantVMwareworkstation

        module Action

            class HasSnapshot

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    if env[:snap_name].nil?
                        env[:snap_name] = env[:machine].provider.driver.snapshot_list.last
                    end

                    env[:result] = env[:machine].provider.driver.has_snapshot?(env[:snap_name])

                    @app.call(env)

                end

            end

        end

    end

end
