
# frozen_string_literal: true

require 'digest'

module Suppository
  class Checksummed
    attr_reader :path

    def initialize(path)
      @path = File.expand_path(path)
    end

    def md5
      @md5 ||= Digest::MD5.file(@path).hexdigest
    end

    def sha1
      @sha1 ||= Digest::SHA1.file(@path).hexdigest
    end

    def sha2
      @sha2 ||= Digest::SHA2.file(@path).hexdigest
    end
  end
end
