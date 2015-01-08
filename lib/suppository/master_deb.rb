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
      "#{@attr['Package']}_#{@attr['Version']}_#{@attr['Architecture']}.deb"
    end

    def full_attr
      full_attrs = @attr
      full_attrs['Size'] = size
      full_attrs['Filename'] = filename
      full_attrs['MD5Sum'] = @md5sum
      full_attrs['SHA1'] = @sha1
      full_attrs['SHA256'] = @sha256
      full_attrs
    end

    def size
      File.size(@path)
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
