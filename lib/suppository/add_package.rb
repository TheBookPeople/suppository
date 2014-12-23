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
      "#{@repository.suppository}/#{File.basename(@deb)}"
    end
  end
end
