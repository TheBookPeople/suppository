HELP = <<-EOS
Example usage:

  suppository help
    - Display this Help message

  suppository version
    - Display version

  suppository create REPOSITORY_PATH
    - Create new empty repository in REPOSITORY_PATH

  suppository add REPOSITORY_PATH DIST COMPONENT DEB_FILE
    - Add DEB_FILE to DIST and COMPONENT of repository at REPOSITORY_PATH

EOS

module Suppository
  def self.help
    HELP
  end
end
