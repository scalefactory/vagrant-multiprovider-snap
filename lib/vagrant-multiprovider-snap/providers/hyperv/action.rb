require "vagrant/action/builder"

module VagrantPlugins

    module HyperV

        module Action

            autoload :SnapshotTake,              File.expand_path("../action/snapshot_take.rb", __FILE__)
            autoload :SnapshotDelete,            File.expand_path("../action/snapshot_delete.rb", __FILE__)
            autoload :SnapshotRollback,          File.expand_path("../action/snapshot_rollback.rb", __FILE__)
            autoload :HasSnapshot,               File.expand_path("../action/has_snapshot.rb", __FILE__)
            autoload :MessageSnapshotNotDeleted, File.expand_path("../action/message_snapshot_not_deleted.rb", __FILE__)
            autoload :MessageSnapshotNotCreated, File.expand_path("../action/message_snapshot_not_created.rb", __FILE__)

            def self.action_snapshot_take
                Vagrant::Action::Builder.new.tap do |b|
                    b.use HandleBox
                    b.use Call, IsState, :not_created do |env, b1|
                        if env[:result]
                            b1.use Message, I18n.t("vagrant_hyperv.message_not_created")
                            next
                        end

                        b1.use SnapshotTake
                    end
                end
            end

            def self.action_snapshot_delete
                Vagrant::Action::Builder.new.tap do |b|
                    b.use HandleBox
                    b.use Call, IsState, :not_created do |env, b1|

                        if env[:result]
                            b1.use Message, I18n.t("vagrant_hyperv.message_not_created")
                            next
                        end

                        b1.use Call, HasSnapshot do |env1, b2|
                            if env1[:result]
                                b2.use Call, SnapshotDelete do |env2,b3|
                                    if env2[:result]
                                        b3.use MessageSnapshotNotDeleted
                                    end
                                end
			    else
				b2.use MessageSnapshotNotCreated
			    end
                        end

                    end
                end
            end

            def self.action_snapshot_rollback
                Vagrant::Action::Builder.new.tap do |b|
                    b.use HandleBox
                    b.use Call, IsState, :not_created do |env, b1|
                        if env[:result]
                            b1.use Message, I18n.t("vagrant_hyperv.message_not_created")
                            next
                        end

                        b1.use SnapshotRollback
                        b1.use WaitForIPAddress
                        b1.use WaitForCommunicator, [:running]
                    end
                end
            end

       end

    end

end

        
