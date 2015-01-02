require 'rubygems'
require 'spec_helper'
require 'suppository/master_deb'

describe Suppository::MasterDeb do

  before(:each) do
    @instance = Suppository::MasterDeb.new('/tmp/repo123/.suppository/12_3456_78910.deb')
  end
    
  it "md5sum" do
    expect(@instance.md5sum).to eql '12'
  end
  
  it "sha1" do
    expect(@instance.sha1).to eql '3456'
  end
  
  it "sha256" do
    expect(@instance.sha256).to eql '78910'
  end
   
end
  
  