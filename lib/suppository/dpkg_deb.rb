
# frozen_string_literal: true

require 'suppository/dpkg_deb_line'
require 'suppository/command_runner'

module Suppository
  class DpkgDeb
    attr_reader :attibutes

    def initialize(deb_path)
      command = CommandRunner.new('dpkg-deb', "-f #{deb_path}")
      @attibutes = parser(command.run)
    end

    private

    def parser(output)
      attibutes = {}
      output.each_line do |line|
        attibute = parser_line(line)
        attibutes = attibutes.merge(attibute) { |_, first, second| first + second }
      end
      attibutes
    end

    def parser_line(output_line)
      DpkgDebLine.new(output_line).attributes
    end
  end
end
