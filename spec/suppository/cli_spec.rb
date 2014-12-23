require 'rubygems'
require 'spec_helper'
require 'suppository/version'
require 'suppository/cli'
require 'suppository/create_repository'

describe Suppository::CLI do
  
  before(:each) do
    IO.any_instance.stub(:puts)
  end
  
  it "can create new repository" do    
    creator = double(Suppository::CreateRepository)
    Suppository::CreateRepository.should_receive(:new).with("/tmp/repo123") {creator}
    creator.should_receive(:run)
    Suppository::CLI.run(["create", "/tmp/repo123"])
  end
  
  
end
  
  