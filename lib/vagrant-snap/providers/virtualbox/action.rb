require "vagrant/action/builder"

module VagrantPlugins

    module ProviderVirtualBox

        module Action

            autoload :SnapshotTake,     File.expand_path("../action/snapshot_take.rb", __FILE__)
            autoload :SnapshotRollback, File.expand_path("../action/snapshot_rollback.rb", __FILE__)

            def self.action_snapshot_take
                Vagrant::Action::Builder.new.tap do |b|
                    b.use CheckVirtualbox
                    b.use Call, Created do |env, b2|
                        if env[:result]
                            b2.use CheckAccessible
                            b2.use SnapshotTake
                        else
                            b2.use MessageNotCreated
                        end
                    end
                end
            end

            def self.action_snapshot_rollback
                Vagrant::Action::Builder.new.tap do |b|
                    b.use CheckVirtualbox
                    b.use Call, Created do |env, b2|
                        if env[:result]
                            b2.use CheckAccessible
                            b2.use SnapshotRollback
                        else
                            b2.use MessageNotCreated
                        end
                    end
                end
            end

       end

    end

end

        
