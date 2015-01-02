HELP = <<-EOS
Example usage:
  suppository create REPOSITORY_PATH
  suppository add REPOSITORY DIST COMPONENT DEB_FILE
EOS

module Suppository
  def self.help
    HELP
  end
end
