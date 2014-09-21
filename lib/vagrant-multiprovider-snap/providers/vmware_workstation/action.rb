require "vagrant/action/builder"

module HashiCorp

    module VagrantVMwareworkstation

        module Action

            autoload :SnapshotTake,              File.expand_path("../action/snapshot_take.rb", __FILE__)
            autoload :SnapshotRollback,          File.expand_path("../action/snapshot_rollback.rb", __FILE__)
            autoload :SnapshotDelete,            File.expand_path("../action/snapshot_delete.rb", __FILE__)
            autoload :HasSnapshot,               File.expand_path("../action/has_snapshot.rb", __FILE__)
            autoload :MessageSnapshotNotCreated, File.expand_path("../action/message_snapshot_not_created.rb", __FILE__)

            def self.action_snapshot_take
                Vagrant::Action::Builder.new.tap do |b|
                    b.use CheckVMware
                    b.use Call, Created do |env, b2|
                        if env[:result]
                            b2.use SnapshotTake
                        else
                            b2.use MessageNotCreated
                        end
                    end
                end
            end

            def self.action_snapshot_delete
                Vagrant::Action::Builder.new.tap do |b|
                    b.use CheckVMware
                    b.use Call, Created do |env, b2|
                        if env[:result]
                            b2.use Call, HasSnapshot do |env2, b3|
                                if env2[:result]
                                    b3.use SnapshotDelete
                                else
                                    b3.use MessageSnapshotNotDeleted
                                end
                            end
                        else
                            b2.use MessageNotCreated
                        end
                    end
                end
            end

            def self.action_snapshot_rollback
                Vagrant::Action::Builder.new.tap do |b|
                    b.use CheckVMware
                    b.use Call, Created do |env, b2|
                        if env[:result]
                            b2.use Call, HasSnapshot do |env2, b3|
                                if env2[:result]
                                    b3.use SnapshotRollback
                                    b3.use WaitForCommunicator, [:restoring, :running]
                                else
                                    b3.use MessageSnapshotNotCreated
                                end
                            end
                        else
                            b2.use MessageNotCreated
                        end
                    end
                end
            end
       end

    end

end

        
