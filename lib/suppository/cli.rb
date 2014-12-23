require 'suppository/create_repository'

module Suppository
  class CLI
    def self.run(args)
      if args.first == 'version'
        puts "Subository Version #{Suppository::VERSION}"
        return
      end
      Suppository::CreateRepository.new(args[1]).run
    end
  end
end
