require 'rubygems'
require 'spec_helper'
require 'suppository/version'

describe Suppository do
  
  it "has a version number" do
    Suppository::VERSION.length.should be > 0
  end
  
end
  
  