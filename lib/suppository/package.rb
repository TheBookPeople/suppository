module Suppository
  class Package
    def initialize(parent_path, deb)
      @deb = deb
      @parent_path = parent_path
    end
    
    def content
<<-EOS
Package: #{@deb.package}
Version: #{@deb.version}
Architecture: #{@deb.architecture}
Maintainer: #{@deb.maintainer}
Installed-Size: #{@deb.installed_size}
Filename: #{@parent_path}/#{@deb.filename}
Size: #{@deb.size}
MD5sum: #{@deb.md5sum}
SHA1: #{@deb.sha1}
SHA256: #{@deb.sha256}
Section: #{@deb.section}
Priority: #{@deb.priority}
Description: #{@deb.description}

      EOS
    end
  end
end
