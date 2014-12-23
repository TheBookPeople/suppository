require 'rubygems'
require 'spec_helper'
require 'suppository/create_repository'

describe Suppository::CreateRepository do

  include FakeFS::SpecHelpers

  before(:each) do
    IO.any_instance.stub(:puts)
    @creator = Suppository::CreateRepository.new("/tmp/repo123/")
    @repository = "/tmp/repo123/"
    @dists = ['natty','lucid', 'precise', 'soucy', 'trusty']
    @archs = ['amd64','i386']
  end

  it "can create new repository" do
    STDOUT.should_receive(:puts).with("Creating new Repository @ /tmp/repo123/")
    @creator.run
  end

  it "can create new repository at diffrent location" do
    STDOUT.should_receive(:puts).with("Creating new Repository @ /tmp/repo321")
    creator = Suppository::CreateRepository.new("/tmp/repo321")
    creator.run
  end

  it "creates repository root folder" do
    @creator.run
    File.directory?("/tmp/repo123/").should be_true
  end

  it "creates a .supository file" do
    @creator.run
    File.directory?("/tmp/repo123/.supository").should be_true
  end

  it "aborts if file supository already exists" do
    FileUtils.mkdir_p "#{@repository}/.supository"
    get_exception{@creator.run}.should eql "#{@repository} is already a repository"
  end

  it "creates folder structure" do
    @creator.run
    @dists.each do |dist|
      @archs.each do |arch|
        File.directory?("#{@repository}/dists/#{dist}/internal/binary-#{arch}").should be_true
      end
    end

  end




end

