
module Suppository
  class Package
    def initialize(parent_path, deb)
      @deb = deb
      @parent_path = parent_path
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def content
      result = "Package: #{@deb.package}\n"
      result << "Version: #{@deb.version}\n"
      result << "Architecture: #{@deb.architecture}\n"
      result << "Maintainer: #{@deb.maintainer}\n"
      result << "Installed-Size: #{@deb.installed_size}\n"
      result << "Filename: #{filename}\n"
      result << "Size: #{@deb.size}\n"
      result << "MD5sum: #{@deb.md5sum}\n"
      result << "SHA1: #{@deb.sha1}\n"
      result << "SHA256: #{@deb.sha256}\n"
      result << "Section: #{@deb.section}\n"
      result << "Priority: #{@deb.priority}\n"
      result << "Description: #{@deb.description}\n"
      result << "\n"
    end

    private

    def filename
      "#{@parent_path}/#{@deb.filename}"
    end
  end
end