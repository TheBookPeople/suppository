require 'rubygems'
require 'spec_helper'
require 'suppository/repository'

describe Suppository::Repository do

  before(:each) do
    @repository = Suppository::Repository.new("/tmp/repo123")
    @dists = %w(natty lucid precise soucy trusty)
    @archs = %w(amd64 i386)
    @suppository ="/tmp/repo123/.suppository"
  end
  
  after(:each) do
    FileUtils.rm_r @repository.path if File.exist? @repository.path
  end

  it "has a path" do
    expect(@repository.path).to eql "/tmp/repo123"
  end
  
  it "converts relative path to absolute" do
    repository = Suppository::Repository.new("./repo123")
    expect(repository.path).to eql File.expand_path('./repo123')
  end
  
  it "has a dists" do
    expect(@repository.dists).to eql @dists
  end
  
  it "has a archs" do
    expect(@repository.archs).to eql @archs
  end
  
  it "has a suppository" do
    expect(@repository.suppository).to eql @suppository
  end
  
  describe 'exist?' do
  
    it "false" do
      expect(@repository.exist?).to be_falsy
    end
  
    it "true" do
      FileUtils.mkdir_p @suppository
      expect(@repository.exist?).to be_truthy
    end
  end


end

