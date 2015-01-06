require 'rubygems'
require 'suppository/master_deb'
require 'suppository/repository'
require 'suppository/exceptions'
require 'suppository/package'
require 'suppository/release'
require 'suppository/logger'
require 'fileutils'
require 'digest'
require 'zlib'
require 'English'

module Suppository
  class AddCommand
    include Suppository::Logger

    def initialize(args)
      fail UsageError if args.nil? || args.length != 4

      @repository = Suppository::Repository.new(args[0])
      @dist = args[1]
      @component = args[2]
      @deb = args[3]
    end

    def run
      assert_repository_exists
      assert_dist_exists
      assert_component_exists

      create_suppository_file
      create_dist_file suppository_file

      Suppository::Release.new(@repository.path, @dist).create
      message = "#{@deb} added to repository #{@repository.path}, #{@dist} #{@component}"
      log_success message
    end

    private

    def assert_repository_exists
      message = "#{@repository.path} is not a valid repository.\n"
      message << "You can create a new repository by running the following command\n\n"
      message << "   suppository create #{@repository.path}"
      fail InvalidRepositoryError, message  unless @repository.exist?
    end

    def assert_dist_exists
      supported_dist = @repository.dists.join(', ')
      message = "#{@dist} does not exist, try one of the following #{supported_dist}"
      fail InvalidDistribution, message  unless File.exist?("#{dist_path}")
    end

    def assert_component_exists
      message = "#{@component} does not exist, try internal instead"
      fail InvalidComponent, message unless File.exist?("#{component_path}")
    end

    def create_suppository_file
      FileUtils.copy_file(@deb, suppository_file, true)
    end

    def create_dist_file(master_file)
      @repository.archs.each do |arch|
        FileUtils.ln_s master_file, dist_file(arch), :force => true
        update_packages master_file, arch
      end
    end

    def update_packages(master_file, arch)
      deb = Suppository::MasterDeb.new(master_file)
      file = package_file(arch)
      package_info = Suppository::Package.new(internal_path(arch), deb).content
      open(file, 'a') { |f| f.puts package_info }
      gzip file
    end

    def gzip(file)
      gz_file = "#{file}.gz"
      Zlib::GzipWriter.open(gz_file) do |gz|
        gz.mtime = File.mtime(file)
        gz.orig_name = file
        gz.write IO.read(file)
      end
    end

    def dist_file(arch)
      filename = Suppository::MasterDeb.new(suppository_file).filename
      "#{component_path}/binary-#{arch}/#{filename}"
    end

    def package_file(arch)
      "#{component_path}/binary-#{arch}/Packages"
    end

    def internal_path(arch)
      "dists/#{@dist}/#{@component}/binary-#{arch}"
    end

    def suppository_file
      "#{suppository}/#{md5}_#{sha1}_#{sha2}.deb"
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

    def md5
      @md5 ||= Digest::MD5.file(@deb).hexdigest
    end

    def sha1
      @sha1 ||= Digest::SHA1.file(@deb).hexdigest
    end

    def sha2
      @sha2 ||= Digest::SHA2.file(@deb).hexdigest
    end
  end
end
