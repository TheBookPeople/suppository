require 'rubygems'
require 'suppository/create_command'
require 'suppository/add_command'
require 'suppository/version_command'
require 'suppository/exceptions'

module Suppository
  class CLI
    def self.run(args)
      fail UsageError if args.empty?
      cmd = args.delete_at(0)

      begin
        clazz(cmd).new(args).run
      rescue NameError
        raise UsageError
      end
    end

    def self.clazz(cmd)
      clazz_name(cmd).split('::').inject(Object) { |a, e| a.const_get e }
    end

    def self.clazz_name(cmd)
      "Suppository::#{cmd.capitalize}Command"
    end
  end
end
