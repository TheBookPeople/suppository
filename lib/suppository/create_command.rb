module Suppository
  class CreateCommand
    def initialize(args)
      @repository = repository(args[0])
    end

    def run
      assert_not_created
      create_repository
    end

    private
    
    def repository(path)
      Suppository::Repository.new(path)
    end
    
    def assert_not_created
      File.exist?(suppository) ? fail("#{path} is already a repository") : ''
    end
    
    def create_repository
      puts "Creating new Repository @ #{path}"
      FileUtils.mkdir_p "#{suppository}"
      create_dists_folders
    end
    
    def create_dists_folders
      @repository.dists.each do |dist|
        create_archs_folders dist
      end
    end
    
    def create_archs_folders(dist)
      @repository.archs.each do |arch|
        create_folder(path, dist, arch)
      end
    end

    def create_folder(path, dist, arch)
      dir_path = "#{path}/dists/#{dist}/internal/binary-#{arch}"
      FileUtils.mkdir_p dir_path
    end

    def suppository
      @repository.suppository
    end

    def path
      @repository.path
    end
  end
end
