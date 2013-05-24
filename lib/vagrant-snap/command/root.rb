require 'optparse'

module VagrantSnap

    module Command

        class Root < Vagrant.plugin("2", :command)

            def initialize(argv, env)

                super

                @main_args, @sub_command, @sub_args = split_main_and_subcommand(argv)

                @subcommands = Vagrant::Registry.new

                @subcommands.register(:take) do
                    require_relative "take"
                    Take
                end

                @subcommands.register(:rollback) do
                    require_relative "rollback"
                    Rollback
                end

            end

            def execute

                if @main_args.include?("-h") || @main_args.include?("--help")
                    return help
                end

                command_class = @subcommands.get(@sub_command.to_sym) if @sub_command
                return help if !command_class || !@sub_command

                # Initialize and execute the command class
                command_class.new(@sub_args, @env).execute

            end

            def help
                puts "TODO"
            end

        end

    end

end
