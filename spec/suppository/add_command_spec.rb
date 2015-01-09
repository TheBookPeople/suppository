
require 'spec_helper'
require 'suppository/add_command'
require 'suppository/repository'
require 'suppository/release'
require 'suppository/create_command'
require 'suppository/exceptions'

describe Suppository::AddCommand do
    
  before(:each) do
    repository_path = "/tmp/supposotory_test_#{Time.now.to_f}"
    @file_name = 'e5ca0a9797acda4bfe8404524f0976b3_b37ce9b17405d93c323c0b8bbe167c6f2dccfe02_5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555.deb'
    @second_file = '2f860ed12d2ad99bacc78d95fb9e7989_323ee30c17a0ca4bbb2b95032fc79f84f4ca26f2_66bce137768403d517468a1f70bd98644558cd000f250dd8cc2faeedda5d4b2f.deb'
    @repository = Suppository::Repository.new(repository_path)
    Suppository::CreateCommand.new([@repository.path]).run
    @dist = 'trusty'
    @component = 'internal'
    @adder = Suppository::AddCommand.new([@repository.path, @dist, @component, deb_file])
  end
  
  after(:each) do
    FileUtils.rm_r @repository.path
  end
  
  it "add the same package again" do  
  	release = double(Suppository::Release)
	  expect(release).to receive(:create).twice
	  expect(Suppository::Release).to receive(:new).twice.with(@repository.path, @dist, false) { release }
    @adder.run
    @adder.run
    expect(File.file?("#{@repository.suppository}/#{@file_name}")).to be_truthy
  end

  describe "expects release to work -" do
    before(:each) do
      release = double(Suppository::Release)
      expect(release).to receive(:create)
      expect(Suppository::Release).to receive(:new).with(@repository.path, @dist, false) { release }
    end

    it "add suppository file" do  
      @adder.run
      expect(File.file?("#{@repository.suppository}/#{@file_name}")).to be_truthy
    end

    it "supports globs for deb file" do  
      @adder = Suppository::AddCommand.new([@repository.path, @dist, @component, deb_file_glob])
      @adder.run
      expect(File.file?("#{@repository.suppository}/#{@file_name}")).to be_truthy
      expect(File.file?("#{@repository.suppository}/#{@second_file}")).to be_truthy
    end

    it "adds package to dists" do  
      @adder.run
      @repository.dists.each do |dist|
        @repository.archs.each do |arch|
          if dist == @dist
            expect(File.file?("#{@repository.path}/dists/#{dist}/#{@component}/binary-#{arch}/curl_7.22.0-3ubuntu4.11_amd64.deb")).to be_truthy
          else
            expect(File.file?("#{@repository.path}/dists/#{dist}/#{@component}/binary-#{arch}/curl_7.22.0-3ubuntu4.11_amd64.deb")).to be_falsy
          end
        end
      end
    end


    it "updates Packages file" do  
      supository_file = "#{@repository.suppository}/#{@file_name}"
      @adder.run
      @repository.archs.each do |arch|
        internal_path = "dists/#{@dist}/#{@component}/binary-#{arch}"
        path = "#{@repository.path}/#{internal_path}"
        packages_path = "#{path}/Packages"
        deb = Suppository::MasterDeb.new(supository_file)
        content = Suppository::Package.new(internal_path, deb).content
        expect(File.read(packages_path)).to match content
      end
    end

    it "updates Packages.gz file" do  
      supository_file = "#{@repository.suppository}/#{@file_name}"
      @adder.run
      @repository.archs.each do |arch|
        internal_path = "dists/#{@dist}/#{@component}/binary-#{arch}"
        path = "#{@repository.path}/#{internal_path}"
        packages_path = "#{path}/Packages.gz"
        deb = Suppository::MasterDeb.new(supository_file)
        content = Suppository::Package.new(internal_path,deb).content
        result =""
        Zlib::GzipReader.open(packages_path) {|gz|
          result << gz.read
        }

        expect(result).to match content
      end
    end
  end
  
  it "cant add package to new dists" do  
    adder = Suppository::AddCommand.new([@repository.path, 'new_dist', @component, deb_file]) 
    expect { 
     adder.run
    }.to raise_error(InvalidDistribution)
  end
  
  it "cant add package to new component" do  
    adder = Suppository::AddCommand.new([@repository.path, @dist, 'testing', deb_file])
    expect { 
      adder.run
    }.to raise_error(InvalidComponent)
  end
  
  it "cant add package to non existant repository" do 
    adder = Suppository::AddCommand.new(['boom', @dist, 'testing', deb_file])
  
    expect { 
      adder.run
     }.to raise_error(InvalidRepositoryError)
  end
  
  it "needs non nil arguments" do  
    expect { 
      Suppository::AddCommand.new(nil)
    }.to raise_error(UsageError)
  end
  
  it "needs arguments" do  
    expect { 
      Suppository::AddCommand.new([])
    }.to raise_error(UsageError)
  end

  it "needs four arguments" do  
    expect { 
      Suppository::AddCommand.new([@repository.path, @dist, 'testing'])
    }.to raise_error(UsageError)
  end

end

