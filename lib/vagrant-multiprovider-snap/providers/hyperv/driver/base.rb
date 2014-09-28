module VagrantPlugins

    module HyperV

        class Driver

            def snapshot_take(name)
                execute_snap("snapshot_vm.ps1", { VmId: vm_id, SnapName: (name || "vagrant-snap-#{Time.now.to_i}") } )
            end

            def snapshot_rollback(name)
                execute_snap("rollback_vm.ps1", { VmId: vm_id,  SnapName: (name || snapshot_list.last) } )
            end

            def snapshot_list
                snaps = execute_snap("list_snapshots.ps1", { VmID: vm_id } )
		snaps.map { |s| s['Name'] }
            end

            def snapshot_delete(name)
                execute_snap("snapshot_delete.ps1", {VmID: vm_id, SnapName: name})
            end

            def has_snapshot?(name=nil)
		if name.nil?
		    snapshot_list.length > 0
		else
                    snapshot_list.include?(name)
		end
            end

            protected

            # These methods copied and modified from existing hyperv driver
            # TODO: think about how we might refactor upstream to support
            # this properly.

            def execute_snap(path, options)

                r = execute_snap_powershell(path, options)
                if r.exit_code != 0
                  raise Errors::PowerShellError,
                    script: path,
                    stderr: r.stderr
                end

                # We only want unix-style line endings within Vagrant
                r.stdout.gsub!("\r\n", "\n")
                r.stderr.gsub!("\r\n", "\n")

                error_match  = ERROR_REGEXP.match(r.stdout)
                output_match = OUTPUT_REGEXP.match(r.stdout)

                if error_match
                  data = JSON.parse(error_match[1])

                  # We have some error data.
                  raise Errors::PowerShellError,
                    script: path,
                    stderr: data["error"]
                end

                # Nothing
                return nil if !output_match
                return JSON.parse(output_match[1])

            end

            def execute_snap_powershell(path, options, &block)
                lib_path = Pathname.new(File.expand_path("../scripts", __FILE__))
                path = lib_path.join(path).to_s.gsub("/", "\\")
                options = options || {}
                ps_options = []
                options.each do |key, value|
                  ps_options << "-#{key}"
                  ps_options << "'#{value}'"
                end

                # Always have a stop error action for failures
                ps_options << "-ErrorAction" << "Stop"

                opts = { notify: [:stdout, :stderr, :stdin] }
                Vagrant::Util::PowerShell.execute(path, *ps_options, **opts, &block)
            end
                

        end

    end

end
