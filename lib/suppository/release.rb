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
      open(@release_file, 'w') { |f| f.puts content }
    end

    # rubocop:disable Metrics/AbcSize
    def content
      result = "Codename: #{@dist}\n"
      result << "Architectures: #{architectures}\n"
      result << "Components: #{components}\n"
      result << "Date: #{date}\n"
      result << package_hashes
    end

    def package_hashes
      result = "MD5Sum:\n"
      packages.each { |f| result << puts_hash(f, Digest::MD5.file(f)) }
      result << "SHA1:\n"
      packages.each { |f| result << puts_hash(f, Digest::SHA1.file(f)) }
      result << "SHA256:\n"
      packages.each { |f| result << puts_hash(f, Digest::SHA256.file(f)) }
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
      @packages ||= Dir.glob("#{@dist_path}/*/*/Packages*")
    end

    def puts_hash(f, hash)
      relative = f.split(@dist_path).pop[1..-1]
      sprintf(" %s %17d %s\n", hash, File.size(f), relative)
    end

    def date
      Time.new.strftime('%a, %d %b %Y %H:%M:%S %Z')
    end

    def components
      component_dirs = Dir.glob("#{@dist_path}/*").select { |f| File.directory? f }
      component_dirs.collect { |d| File.basename(d) }.join(' ')
    end

    def architectures
      arch_dirs = Dir.glob("#{@dist_path}/*/*").select { |f| File.directory? f }
      arch_dirs.collect { |d| File.basename(d).split('-')[1] }.uniq.join(' ')
    end
  end
end
