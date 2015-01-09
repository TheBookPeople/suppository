
require 'spec_helper'
require 'suppository/help'

describe Suppository do
  
  it "has usage string" do    
    expect(Suppository.help).to eql("Example usage:\n\n  suppository help\n    - Display this Help message\n\n  suppository version\n    - Display version\n\n  suppository create <REPOSITORY_PATH>\n    - Create new empty repository in REPOSITORY_PATH\n\n  suppository add <REPOSITORY_PATH> <DIST> <COMPONENT> <DEB_FILE> [--unsigned]\n    - Add DEB_FILE to DIST and COMPONENT of repository at REPOSITORY_PATH\n\n")
  end
end
  
  
