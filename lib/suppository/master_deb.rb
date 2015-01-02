require 'suppository/deb'

module Suppository
  class MasterDeb < Deb
    attr_reader :md5sum, :sha256, :sha1
    
    def initialize(path)
      super(path)
      file_name = File.basename(path, ".deb")
      hashes = file_name.split('_')
      @md5sum = hashes[0]
      @sha1 = hashes[1]
      @sha256 = hashes[2]
    end

  end
end
