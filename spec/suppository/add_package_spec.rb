require 'rubygems'
require 'spec_helper'
require 'suppository/add_package'
require 'suppository/repository'
require 'suppository/create_repository'

describe Suppository::AddPackage do


  before(:each) do
    @repository = Suppository::Repository.new("/tmp/supposotory_test_#{Time.now.to_f}")
    Suppository::CreateRepository.new(@repository).run
    test_deb = File.expand_path(File.dirname(__FILE__)+"../../../fixtures/curl_7.22.0-3ubuntu4.11_amd64.deb")
    @adder = Suppository::AddPackage.new(@repository, test_deb)
  end
  
  after(:each) do
    FileUtils.rm_r @repository.path
  end
  

  it "can add a package to the supposotory" do  
    @adder.run
    file_name = 'e5ca0a9797acda4bfe8404524f0976b3_b37ce9b17405d93c323c0b8bbe167c6f2dccfe02_5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555.deb'
    expect(File.file?("#{@repository.suppository}/#{file_name}")).to be_truthy
  end




end

