
require 'zlib'

module Suppository
  module Gzip
    def self.compress(file)
      Zlib::GzipWriter.open("#{file}.gz") do |gz|
        gz.mtime = File.mtime(file)
        gz.orig_name = file
        gz.write IO.read(file)
      end
    end
  end
end
