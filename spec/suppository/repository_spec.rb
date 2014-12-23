require 'rubygems'
require 'spec_helper'
require 'suppository/repository'

describe Suppository::Repository do

  before(:each) do
    IO.any_instance.stub(:puts)
    @repository = Suppository::Repository.new("/tmp/repo123")
    @dists = ['natty','lucid', 'precise', 'soucy', 'trusty']
    @archs = ['amd64','i386']
    @suppository ="/tmp/repo123/.suppository"
  end

  it "has a path" do
    @repository.path.should eql "/tmp/repo123"
  end
  
  it "has a dists" do
    @repository.dists.should eql @dists
  end
  
  it "has a archs" do
    @repository.archs.should eql @archs
  end
  
  it "has a suppository" do
    @repository.suppository.should eql @suppository
  end


end

