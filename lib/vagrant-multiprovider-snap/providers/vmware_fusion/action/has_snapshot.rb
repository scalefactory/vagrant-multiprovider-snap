module HashiCorp

    module VagrantVMwarefusion

        module Action

            class HasSnapshot

                def initialize(app, env)
                    @app = app
                end

                def call(env)

                    env[:result] = env[:machine].provider.driver.has_snapshot?(env[:snap_name])

                    @app.call(env)

                end

            end

        end

    end

end
