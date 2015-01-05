require 'rubygems'
require 'spec_helper'
require 'suppository/master_deb'

describe Suppository::MasterDeb do
  
  before(:all) do
    @valid_file_name = 'e5ca0a9797acda4bfe8404524f0976b3_b37ce9b17405d93c323c0b8bbe167c6f2dccfe02_5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555.deb'
  end
  
  describe 'valid file' do  
    
    before(:each) do
      master_deb_file = "/tmp/repo123/.suppository/#{@valid_file_name}"
      dpkg = double(Suppository::DpkgDeb)
      expect(dpkg).to receive(:attibutes) {[]}
      expect(Suppository::DpkgDeb).to receive(:new).with(master_deb_file) {dpkg}
      @instance = Suppository::MasterDeb.new(master_deb_file)
    end
    
    it "md5sum" do
      expect(@instance.md5sum).to eql 'e5ca0a9797acda4bfe8404524f0976b3'
    end
  
    it "sha1" do
      expect(@instance.sha1).to eql 'b37ce9b17405d93c323c0b8bbe167c6f2dccfe02'
    end
  
    it "sha256" do
      expect(@instance.sha256).to eql '5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555'
    end

  end
  
  
  describe 'invalid file' do  
    
    it "checks file is in correct folder" do
      master_deb_file = "/tmp/repo123/#{@valid_file_name}"
      exception = nil
      begin
       Suppository::MasterDeb.new(master_deb_file)
      rescue InvalidMasterDeb => e
        exception = e
      end
    
      expect(exception.message).to be_eql 'Master deb must be in the .suppository folder'
    end
    
    it "checks file has correct name" do
      master_deb_file = '/tmp/repo123/.suppository/123456_78910.deb'
      exception = nil
      begin
       Suppository::MasterDeb.new(master_deb_file)
      rescue InvalidMasterDeb => e
        exception = e
      end
    
      expect(exception.message).to be_eql 'Master deb must have the following name {md5}_{sha1}_{sha256}.deb'
    end
  
  end
   
end
  
  