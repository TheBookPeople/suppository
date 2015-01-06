
module Suppository
  class Package
    def initialize(parent_folder, deb)
      @deb = deb
      @parent_folder = parent_folder
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def content
      result = "Package: #{@deb.package}\n"
      result << "Version: #{@deb.version}\n"
      result << "Architecture: #{@deb.architecture}\n"
      result << "Maintainer: #{@deb.maintainer}\n"
      result << "Installed-Size: #{@deb.installed_size}\n"
      result << "Filename: #{filename}\n"
      result << "Size: #{@deb.size}\n" if defined?(@deb.size)
      result << "MD5sum: #{@deb.md5sum}\n"
      result << "SHA1: #{@deb.sha1}\n"
      result << "SHA256: #{@deb.sha256}\n"
      result << "Section: #{@deb.section}\n"
      result << "Priority: #{@deb.priority}\n"
      result << "Homepage: #{@deb.homepage}\n" if defined?(@deb.homepage)
      result << "Description: #{@deb.description}\n"
    end

    private

    def filename
      "#{@parent_folder}/#{@deb.filename}"
    end
  end
end
