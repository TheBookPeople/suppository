require 'rubygems'

module Suppository
  class VersionCommand
    def run
      puts "Suppository Version #{Suppository::VERSION}"
    end
  end
end
