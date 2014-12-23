require 'rubygems'
require 'spec_helper'
require 'suppository/version'
require 'suppository/cli'
require 'suppository/repository'
require 'suppository/create_repository'
require 'suppository/add_package'

describe Suppository::CLI do
  
  before(:each) do
    @path = '/tmp/repo123'
    @repository = double(Suppository::Repository)
  end
  
  it "shows current version" do    
    expect{Suppository::CLI.run(['version'])}.to output("Suppository Version 0.0.1\n").to_stdout   
  end
  
  it "can create new repository" do    
    expect(Suppository::Repository).to receive(:new).with(@path) {@repository}
    
    creator = double(Suppository::CreateRepository)
    expect(Suppository::CreateRepository).to receive(:new).with(@repository) {creator}
    expect(creator).to receive(:run)
    Suppository::CLI.run(['create', @path])
  end
  
  it "can add deb to existing repository" do 
    expect(Suppository::Repository).to receive(:new).with(@path) {@repository}
    
    adder = double(Suppository::AddPackage)
    expect(Suppository::AddPackage).to receive(:new).with(@repository, '/tmp/example.deb') {adder}
    expect(adder).to receive(:run)   
    Suppository::CLI.run(['add', @path ,'/tmp/example.deb'])
  end
  
  
end
  
  