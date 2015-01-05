
module Suppository
  class Release
    def initialize(repo_path, dist)
      @dist = dist
      @dist_path = "#{repo_path}/dists/#{dist}"
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
      result << "MD5Sum:\n"
      packages.each { |f| result << puts_hash(f, Digest::MD5.file(f)) }
      result << "SHA1:\n"
      packages.each { |f| result << puts_hash(f, Digest::SHA1.file(f)) }
      result << "SHA256:\n"
      packages.each { |f| result << puts_hash(f, Digest::SHA256.file(f)) }
      result << "SHA512:\n"
      packages.each { |f| result << puts_hash(f, Digest::SHA512.file(f)) }
      result
    end

    def puts_hash(f, hash)
      relative = f.split('/')
      (0..2).each { relative.shift }
      sprintf(" %s %17d %s\n", hash, File.size(f), relative.join('/'))
    end
  end
end
