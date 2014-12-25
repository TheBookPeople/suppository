require 'rubygems'
require 'suppository/create_command'
require 'suppository/add_command'
require 'suppository/version_command'
require 'suppository/exceptions'

module Suppository
  class CLI
    def self.run(args)
      fail UsageError if args.empty?

      case args.delete_at(0)
      when 'version'
        Suppository::VersionCommand.new.run
      when 'create'
        Suppository::CreateCommand.new(args).run
      when 'add'
        Suppository::AddCommand.new(args).run
      else
        fail UsageError
      end
    end
  end
end
