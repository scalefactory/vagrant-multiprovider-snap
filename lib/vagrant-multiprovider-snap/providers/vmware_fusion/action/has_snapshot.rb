module HashiCorp

    module VagrantVMwarefusion

        module Action

            class HasSnapshot

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    if env[:snap_name].nil?
                        snap_name = env[:machine].provider.driver.snapshot_list.last
                    else
                        snap_name = env[:snap_name]
                    end

                    env[:result] = env[:machine].provider.driver.has_snapshot?(snap_name)

                    @app.call(env)

                end

            end

        end

    end

end
