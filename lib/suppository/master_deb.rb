require 'suppository/deb'
require 'suppository/exceptions'
require 'pp'

module Suppository
  class MasterDeb < Deb
    attr_reader :md5sum, :sha256, :sha1

    def initialize(path)
      @path = path

      assert_in_suppository
      checksums = checksums_from_name

      @md5sum = checksums['md5']
      @sha1 = checksums['sha1']
      @sha256 = checksums['sha256']

      super(path)
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
