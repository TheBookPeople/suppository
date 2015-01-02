require 'rubygems'
require 'suppository/deb'
require 'suppository/repository'
require 'suppository/exceptions'

module Suppository
  class AddCommand
    def initialize(args)
      fail UsageError if args.nil? || args.length != 4

      @repository = Suppository::Repository.new(args[0])
      @dist = args[1]
      @component = args[2]
      @deb = args[3]
    end

    def run
      assert_dist_exists
      assert_component_exists

      create_suppository_file
      symlink_file suppository_file
    end

    private

    def assert_dist_exists
      fail InvalidDistribution unless File.exist?("#{dist_path}")
    end

    def assert_component_exists
      fail InvalidComponent unless File.exist?("#{component_path}")
    end

    def create_suppository_file
      FileUtils.copy_file(@deb, suppository_file, true)
    end

    def symlink_file(master_file)
      @repository.archs.each do |arch|
        FileUtils.ln_s master_file, dist_file(arch)
      end
    end

    def dist_file(arch)
      filename = Suppository::Deb.new(@deb).filename
      "#{component_path}/binary-#{arch}/#{filename}"
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
