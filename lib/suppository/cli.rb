require 'suppository/create_repository'

module Suppository
  class CLI
    def self.run(args)
      if args.first == 'version'
        puts "Suppository Version #{Suppository::VERSION}"
        return
      end

      if args.first == 'create'
        Suppository::CreateRepository.new(repository(args[1])).run
        return
      end

      if args.first == 'add'
        Suppository::AddPackage.new(repository(args[1]), args[2]).run
        return
      end
    end

    def self.repository(path)
      Suppository::Repository.new(path)
    end
  end
end
