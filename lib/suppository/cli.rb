
# frozen_string_literal: true

require 'suppository/exceptions'

module Suppository
  class CLI
    def self.run(args)
      raise UsageError if args.empty?
      cmd = args.delete_at(0)

      begin
        clazz(cmd).new(args).run
      rescue LoadError
        raise UsageError
      end
    end

    def self.clazz(cmd)
      require "suppository/#{cmd}_command"
      clazz_name(cmd).split('::').inject(Object) { |a, e| a.const_get e }
    end

    def self.clazz_name(cmd)
      "Suppository::#{cmd.capitalize}Command"
    end
  end
end
