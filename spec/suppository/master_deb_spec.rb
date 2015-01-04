require 'rubygems'
require 'spec_helper'
require 'suppository/master_deb'

describe Suppository::MasterDeb do
  
  before(:each) do
    master_deb_file = '/tmp/repo123/.suppository/12_3456_78910.deb'
    dpkg = double(Suppository::DpkgDeb)
    expect(dpkg).to receive(:attibutes) {[]}
    expect(Suppository::DpkgDeb).to receive(:new).with(master_deb_file) {dpkg}
    @instance = Suppository::MasterDeb.new(master_deb_file)
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
  
  