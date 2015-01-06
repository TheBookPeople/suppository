module Suppository
  class Repository
    attr_reader :path, :dists, :archs, :suppository

    def initialize(path)
      @path = File.expand_path(path)
      @dists = %w(natty lucid precise soucy trusty)
      @archs = %w(amd64 i386)
      @suppository = "#{@path}/.suppository"
    end

    def exist?
      File.exist? @suppository
    end
  end
end
