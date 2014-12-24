module Suppository
  class AddPackage
    def initialize(repository, deb)
      @deb = deb
      @repository = repository
    end

    def run
      FileUtils.copy_file(@deb, destination, true)
    end

    private

    def destination
      "#{suppository}/#{md5}_#{sha1}_#{sha2}.deb"
    end

    def suppository
      @repository.suppository
    end

    def md5
      Digest::MD5.file(@deb).hexdigest
    end

    def sha1
      Digest::SHA1.file(@deb).hexdigest
    end

    def sha2
      Digest::SHA2.file(@deb).hexdigest
    end
  end
end
