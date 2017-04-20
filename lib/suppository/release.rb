# frozen_string_literal: true

require 'suppository/exceptions'
require 'suppository/command_runner'
require 'fileutils'

module Suppository
  class Release
    def initialize(repo_path, dist, unsigned = false)
      @dist = dist
      @unsigned = unsigned
      @dist_path = "#{repo_path}/dists/#{dist}"
      @release_file = "#{@dist_path}/Release"
    end

    def create
      write_file
      sign unless @unsigned
    end

    private

    def write_file
      open(@release_file, 'w') { |f| f.puts content.join('') }
    end

    def content
      result = []
      result << "Codename: #{@dist}\n"
      result << "Architectures: #{architectures}\n"
      result << "Components: #{components}\n"
      result << "Date: #{date}\n"
      result << package_hashes
    end

    def package_hashes
      result = []
      result << md5_hashes
      result << sha1_hashes
      result << sha2_hashes
      result << sha5_hashes
    end

    def md5_hashes
      result = []
      result << "MD5Sum:\n"
      packages.each { |f| result << puts_hash(f, Digest::MD5.file(f)) }
      result
    end

    def sha1_hashes
      result = []
      result << "SHA1:\n"
      packages.each { |f| result << puts_hash(f, Digest::SHA1.file(f)) }
      result
    end

    def sha2_hashes
      result = []
      result << "SHA256:\n"
      packages.each { |f| result << puts_hash(f, Digest::SHA256.file(f)) }
      result
    end

    def sha5_hashes
      result = []
      result << "SHA512:\n"
      packages.each { |f| result << puts_hash(f, Digest::SHA512.file(f)) }
      result
    end

    def sign
      gpg_file = "#{@release_file}.gpg"
      FileUtils.rm_rf(gpg_file)
      CommandRunner.new('gpg', "-abs -o #{gpg_file} #{@release_file}").run
    end

    def packages
      @packages ||= Dir.glob("#{@dist_path}/*/*/Packages*").sort
    end

    def puts_hash(f, hash)
      relative = f.split(@dist_path).pop[1..-1]
      format(" %s %17d %s\n", hash, File.size(f), relative)
    end

    def date
      Time.now.getutc.strftime('%a, %d %b %Y %H:%M:%S %Z')
    end

    def components
      directories("#{@dist_path}/*").join(' ')
    end

    def architectures
      directories("#{@dist_path}/*/*").collect { |d| d.split('-')[1] }.uniq.sort.join(' ')
    end

    def directories(path_pattern)
      directories = Dir.glob(path_pattern).select { |f| File.directory? f }
      directories.collect { |d| File.basename(d) }
    end
  end
end
