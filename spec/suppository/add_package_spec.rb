require 'rubygems'
require 'spec_helper'
require 'suppository/add_package'
require 'suppository/repository'
require 'suppository/create_repository'

describe Suppository::AddPackage do


  before(:each) do
    IO.any_instance.stub(:puts)
    @repository = Suppository::Repository.new("/tmp/supposotory_test_#{Time.now.to_f}")
    Suppository::CreateRepository.new(@repository).run
    test_deb = File.expand_path(File.dirname(__FILE__)+"../../../fixtures/mock_software.deb")
    @adder = Suppository::AddPackage.new(@repository, test_deb)
  end
  
  after(:each) do
    FileUtils.rm_r @repository.path
  end
  

  it "can add a package to the supposotory" do  
    @adder.run
    puts "#{@repository.suppository}/mock_software.deb"
    File.file?("#{@repository.suppository}/mock_software.deb").should be_true
  end




end

