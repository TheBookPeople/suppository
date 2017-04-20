
# frozen_string_literal: true

require 'suppository/master_deb'
require 'suppository/repository'
require 'suppository/exceptions'
require 'suppository/package'
require 'suppository/release'
require 'suppository/logger'
require 'suppository/checksummed'
require 'suppository/gzip'
require 'fileutils'

module Suppository
  class AddCommand
    include Suppository::Logger

    def initialize(args)
      @unsigned = parse_params(args)
      @repository = Suppository::Repository.new(args[0])
      @dist = args[1]
      @component = args[2]
      @debs = Dir.glob(args[3])
    end

    def run
      assert_repository_exists
      assert_dist_exists
      assert_component_exists
      assert_debs_exist

      @debs.each { |deb| add_deb Suppository::Checksummed.new(deb) }

      Suppository::Release.new(@repository.path, @dist, @unsigned).create
    end

    private

    def parse_params(args)
      raise UsageError if args.nil? || args.length < 4 || args.length > 5
      raise UsageError if args.length == 5 && args[4] != '--unsigned'
      args.length == 5
    end

    def add_deb(deb)
      create_suppository_file(deb)
      create_dist_file(suppository_file(deb), deb)
      f = File.basename(deb.path)
      message = "#{f} added to repository #{@repository.path}, #{@dist} #{@component}"
      log_success message
    end

    def assert_debs_exist
      raise MissingFile, 'No valid *.deb has been provided.' if @debs.empty?
    end

    def assert_repository_exists
      message = []
      message << "#{@repository.path} is not a valid repository.\n"
      message << "You can create a new repository by running the following command\n\n"
      message << "   suppository create #{@repository.path}"
      raise InvalidRepositoryError, message unless @repository.exist?
    end

    def assert_dist_exists
      supported_dist = @repository.dists.join(', ')
      message = "#{@dist} does not exist, try one of the following #{supported_dist}"
      raise InvalidDistribution, message unless File.exist?(dist_path.to_s)
    end

    def assert_component_exists
      message = "#{@component} does not exist, try internal instead"
      raise InvalidComponent, message unless File.exist?(component_path.to_s)
    end

    def create_suppository_file(deb)
      FileUtils.copy_file(deb.path, suppository_file(deb), true)
    end

    def create_dist_file(master_file, deb)
      @repository.archs.each do |arch|
        FileUtils.ln_s master_file, dist_file(arch, deb), force: true
        update_packages arch
      end
    end

    def update_packages(arch)
      file = package_file(arch)
      FileUtils.rm(file)
      FileUtils.rm("#{file}.gz")
      Dir.glob("#{component_path}/binary-#{arch}/*deb").each do |deb_link|
        update_package(deb_link, arch)
      end
      Suppository::Gzip.compress file
    end

    def update_package(deb_link, arch)
      master_file = File.symlink?(deb_link) ? File.readlink(deb_link) : deb_link
      deb = Suppository::MasterDeb.new(master_file)
      package_info = Suppository::Package.new(internal_path(arch), deb).content
      open(package_file(arch), 'a') { |f| f.puts package_info }
    end

    def dist_file(arch, deb)
      filename = Suppository::MasterDeb.new(suppository_file(deb)).filename
      "#{component_path}/binary-#{arch}/#{filename}"
    end

    def package_file(arch)
      "#{component_path}/binary-#{arch}/Packages"
    end

    def internal_path(arch)
      "dists/#{@dist}/#{@component}/binary-#{arch}"
    end

    def suppository_file(deb)
      "#{suppository}/#{deb.md5}_#{deb.sha1}_#{deb.sha2}.deb"
    end

    def dist_path
      "#{@repository.path}/dists/#{@dist}"
    end

    def component_path
      "#{dist_path}/#{@component}"
    end

    def suppository
      @repository.suppository
    end
  end
end
