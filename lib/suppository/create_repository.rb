module Suppository
  class CreateRepository
    def initialize(repository)
      @repository = repository
      @dists = %w(natty lucid precise soucy trusty)
      @archs = %w(amd64 i386)
      @supository = "#{@repository}/.supository"
    end

    def run
      File.exist?(@supository) ? fail("#{@repository} is already a repository") : ''
      puts "Creating new Repository @ #{@repository}"
      FileUtils.mkdir_p "#{@repository}/.supository"
      @dists.each do |dist|
        @archs.each do |arch|
          dir_path = "#{@repository}/dists/#{dist}/internal/binary-#{arch}"
          FileUtils.mkdir_p dir_path
        end
      end
    end
  end
end
