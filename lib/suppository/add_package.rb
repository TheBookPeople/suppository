module Suppository
  class AddPackage
    def initialize(repository, deb)
      @deb = deb
      @repository=repository
    end

    def run
      FileUtils.copy_file(@deb, @repository.suppository + "/" + File.basename(@deb), true)
    end
  end
end
