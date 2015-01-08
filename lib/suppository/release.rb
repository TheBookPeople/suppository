require 'English'
require 'rubygems'
require 'suppository/exceptions'
require 'fileutils'

module Suppository
  class Release
    def initialize(repo_path, dist, unsigned = false)
      @dist = dist
      @unsigned = unsigned
      @dist_path = "#{repo_path}/dists/#{dist}"
    end

    def create
      release_file = "#{@dist_path}/Release"
      open(release_file, 'w') { |f| f.puts content }

      return if @unsigned

      `which gpg`
      fail(MissingDependencyError, "'gpg' was not found.") unless command_worked

      gpg_file = "#{release_file}.gpg"
      FileUtils.rm_rf(gpg_file)
      gpg_output = `gpg -abs -o #{gpg_file} #{release_file} 2>&1`
      fail(GpgError, gpg_output) unless $CHILD_STATUS.success?
    end

    private

    def command_worked
      $CHILD_STATUS.success?
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def content
      result = "Codename: #{@dist}\n"
      component_dirs = Dir.glob("#{@dist_path}/*").select { |f| File.directory? f }
      components = component_dirs.collect { |d| File.basename(d) }.join(' ')
      arch_dirs = Dir.glob("#{@dist_path}/*/*").select { |f| File.directory? f }
      architectures = arch_dirs.collect { |d| File.basename(d).split('-')[1] }
                      .uniq.join(' ')
      result << "Architectures: #{architectures}\n"
      result << "Components: #{components}\n"
      result << "Date: #{Time.new.strftime('%a, %d %b %Y %H:%M:%S %Z')}\n"
      packages = Dir.glob("#{@dist_path}/*/*/Packages*")

      packages.each { |f| result << puts_hash('MD5Sum', f, Digest::MD5.file(f)) }
      packages.each { |f| result << puts_hash('SHA1', f, Digest::SHA1.file(f)) }
      packages.each { |f| result << puts_hash('SHA256', f, Digest::SHA256.file(f)) }
      packages.each { |f| result << puts_hash('SHA512', f, Digest::SHA512.file(f)) }
      result
    end

    def puts_hash(key, f, hash)
      relative = f.split(@dist_path).pop[1..-1]
      sprintf("%s:\n %s %17d %s\n", key, hash, File.size(f), relative)
    end
  end
end
