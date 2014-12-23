module Suppository
  class CreateRepository
    def initialize(repository)
      @repository = repository
    end

    def run
      File.exist?(@repository.suppository) ? fail("#{@repository.path} is already a repository") : ''
      puts "Creating new Repository @ #{@repository.path}"
      FileUtils.mkdir_p "#{@repository.suppository}"
      @repository.dists.each do |dist|
        @repository.archs.each do |arch|
          dir_path = "#{@repository.path}/dists/#{dist}/internal/binary-#{arch}"
          FileUtils.mkdir_p dir_path
        end
      end
    end
  end
end
