require 'suppository/deb'

module Suppository
  class AddPackage
    def initialize(repository, deb)
      @deb = deb
      @repository = repository
    end

    def run
      master_file = create_master_file
      symlink_files master_file
    end

    private
    
    def create_master_file
      master_file = get_master_file
      FileUtils.copy_file(@deb, master_file, true)
      master_file
    end
    
    def symlink_files(master_file)
      @repository.dists.each do |dist|
        @repository.archs.each do |arch|
          FileUtils.ln_s master_file, dist_file(dist,arch)
        end
      end
    end
    
    def dist_file(dist,arch)
      filename = Suppository::Deb.new(@deb).filename
      "#{@repository.path}/dists/#{dist}/internal/binary-#{arch}/#{filename}"
    end

    def get_master_file
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
