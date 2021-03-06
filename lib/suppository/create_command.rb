
# frozen_string_literal: true

require 'fileutils'
require 'suppository/logger'
require 'suppository/repository'
require 'suppository/exceptions'
require 'suppository/gzip'

module Suppository
  class CreateCommand
    include Suppository::Logger

    def initialize(args)
      assert_arguments args
      @repository = repository(args[0])
    end

    def run
      assert_not_created
      create_repository
    end

    private

    def assert_arguments(args)
      message = 'Create command needs one argument, the path to the new repository'
      raise UsageError, message if args.nil? || args.length != 1
    end

    def repository(path)
      Suppository::Repository.new(path)
    end

    def assert_not_created
      @repository.exist? ? raise("#{path} is already a repository") : ''
    end

    def create_repository
      FileUtils.mkdir_p suppository.to_s
      create_dists_folders
      log_success "Created new Repository - #{path}"
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
      create_packages_file(dir_path)
    end

    def create_packages_file(path)
      packages_file = "#{path}/Packages"
      FileUtils.touch packages_file
      Suppository::Gzip.compress packages_file
    end

    def suppository
      @repository.suppository
    end

    def path
      @repository.path
    end
  end
end
