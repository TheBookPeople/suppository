# frozen_string_literal: true

module Suppository
  class Repository
    attr_reader :path, :dists, :archs, :suppository

    def initialize(path)
      @path = File.expand_path(path)
      @dists = %w[natty lucid precise saucy trusty xenial].sort
      @archs = %w[amd64 i386].sort
      @suppository = "#{@path}/.suppository"
    end

    def exist?
      File.exist? @suppository
    end
  end
end
