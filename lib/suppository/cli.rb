require 'suppository/create_repository'

module Suppository
  class CLI
    def self.run(args)
      if args.first == 'version'
        puts "Suppository Version #{Suppository::VERSION}"
        return
      end
      
      if args.first == 'create'
        repository = Suppository::Repository.new(args[1])
        Suppository::CreateRepository.new(repository).run
        return
      end
      
      if args.first == 'add'
        repository = Suppository::Repository.new(args[1])
        Suppository::AddPackage.new(repository, args[2]).run
        return
      end
      
    end
  end
end
