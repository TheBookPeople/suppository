require 'rubygems'
require 'suppository/tty'
require 'suppository/repository'

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
      FileUtils.mkdir_p "#{suppository}"
      create_dists_folders
      Tty.on_success "Created new Repository - #{path}"
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
      dir_path = "#{path}dists/#{dist}/internal/binary-#{arch}"
      FileUtils.mkdir_p dir_path
      create_packages_file(dir_path)
    end

    def create_packages_file(path)
      packages_file = "#{path}/Packages"
      FileUtils.touch packages_file
      gzip packages_file
    end

    def gzip(file)
      gzip_file = "#{File.dirname(file)}/#{File.basename(file)}.gz"
      Zlib::GzipWriter.open(gzip_file) do |gz|
        gz.mtime = File.mtime(file)
        gz.orig_name = file
        gz.write IO.binread(file)
      end
    end

    def suppository
      @repository.suppository
    end

    def path
      @repository.path
    end
  end
end
