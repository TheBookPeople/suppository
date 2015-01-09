

module Suppository
  class VersionCommand
    def initialize(_)
    end

    def run
      puts "Suppository Version #{Suppository::VERSION}"
    end
  end
end
