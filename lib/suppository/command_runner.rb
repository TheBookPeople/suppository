# frozen_string_literal: true

require 'English'
require 'suppository/exceptions'

module Suppository
  class CommandRunner
    def initialize(command, arguments = '')
      @command = command
      @arguments = arguments
    end

    def run
      assert_exists
      run_command
    end

    private

    def assert_exists
      `which "#{@command}"`
      message = "'#{@command}' was not found."
      raise(CommandMissingError, message) unless $CHILD_STATUS.success?
    end

    def run_command
      output = `#{@command} #{@arguments} 2>&1`
      raise(CommandError, output) unless $CHILD_STATUS.success?
      output
    end
  end
end
