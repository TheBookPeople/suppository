require 'rubygems'
require 'spec_helper'
require 'suppository/create_command'
require 'suppository/repository'

describe Suppository::CreateCommand do

  before(:each) do
    repository_path = "/tmp/suppository_test_#{Time.now.to_f}"
    @repository = Suppository::Repository.new(repository_path)
    @creator = Suppository::CreateCommand.new([@repository.path])
  end
  
  after(:each) do
    FileUtils.rm_r(@repository.path) if File.directory?(@repository.path) 
  end

  it "can create new repository" do
    expect{@creator.run}.to output("==> Created new Repository - #{@repository.path}\n").to_stdout 
  end


  it "creates repository root folder" do
    @creator.run
    expect(File.directory?(@repository.path)).to be_truthy
  end

  it "creates a .supository file" do
    @creator.run
    expect(File.directory?("#{@repository.path}/.suppository")).to be_truthy
  end
  
  it "creates a Packages file" do
    @creator.run
    @repository.dists.each do |dist|
      @repository.archs.each do |arch|
        expect(File.file?("#{@repository.path}/dists/#{dist}/internal/binary-#{arch}/Packages")).to be_truthy
      end
    end
  end
  
  it "creates a Packages.gz file" do
    @creator.run
    @repository.dists.each do |dist|
      @repository.archs.each do |arch|
        file_name = "#{@repository.path}/dists/#{dist}/internal/binary-#{arch}/Packages.gz"     
        expect(Zlib::GzipReader.open(file_name)).to be_truthy
      end
    end
  end


  it "aborts if file suppository already exists" do
    FileUtils.mkdir_p @repository.suppository
    expect(get_exception{@creator.run}).to eql "#{@repository.path} is already a repository"
  end

  it "creates folder structure" do
    @creator.run
    @repository.dists.each do |dist|
      @repository.archs.each do |arch|
        expect(File.directory?("#{@repository.path}/dists/#{dist}/internal/binary-#{arch}")).to be_truthy
      end
    end
  end
  
  it "needs non nil arguments" do  
    expect { 
      Suppository::CreateCommand.new(nil)
    }.to raise_error(UsageError)
  end
  
  it "needs arguments" do  
    expect { 
      Suppository::CreateCommand.new([])
    }.to raise_error(UsageError)
  end

end

