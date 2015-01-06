require 'suppository/exceptions'
require 'suppository/dpkg_deb'

module Suppository
  class MasterDeb
    attr_reader :md5sum, :sha256, :sha1, :dirname

    def initialize(path)
      @path = path

      assert_in_suppository
      checksums = checksums_from_name

      @md5sum = checksums['md5']
      @sha1 = checksums['sha1']
      @sha256 = checksums['sha256']

      @dirname = File.dirname(path)
      @attr = Suppository::DpkgDeb.new(path).attibutes
    end

    def filename
      "#{@attr['package']}_#{@attr['version']}_#{@attr['architecture']}.deb"
    end

    def size
      File.size(@path)
    end

    def method_missing(method_sym, *arguments, &block)
      value = @attr[method_sym.to_s]
      if value
        value
      else
        super
      end
    end

    def respond_to?(method_sym, include_private = false)
      if @attr[method_sym.to_s]
        true
      else
        super
      end
    end

    private

    def assert_in_suppository
      message = 'Master deb must be in the .suppository folder'
      fail InvalidMasterDeb, message unless suppository_file?
    end

    def suppository_file?
      File.dirname(@path).end_with?('.suppository')
    end

    def checksums_from_name
      file_name = File.basename(@path)
      matches = filename_regex.match(file_name)
      message = 'Master deb must have the following name {md5}_{sha1}_{sha256}.deb'
      fail InvalidMasterDeb, message unless matches
      matches
    end

    def filename_regex
      /^(?<md5>[a-f0-9]{32})_(?<sha1>[a-f0-9]{40})_(?<sha256>[a-f0-9]{64})\.deb$/
    end
  end
end
