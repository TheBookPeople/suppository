require 'rubygems'
require 'spec_helper'
require 'suppository/help'

describe Suppository do
  
  it "has usage string" do    
    expect(Suppository.help).to eql("Example usage:\n  suppository create REPOSITORY_PATH\n  suppository add REPOSITORY DIST COMPONENT DEB_FILE\n")
  end
end
  
  