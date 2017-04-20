
# frozen_string_literal: true

require 'spec_helper'
require 'suppository/release'
require 'suppository/create_command'

describe Suppository::Release do
  RELEASE_CONTENT = <<-EOS
Codename: lucid
Architectures: amd64 i386
Components: internal
Date: [A-Za-z]{3}, [0-9]{2} [A-Za-z]{3} [0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2} [A-Z]{3}
MD5Sum:
 [a-f0-9]{32}[ 0-9]{18,18} internal/binary-amd64/Packages
 [a-f0-9]{32}[ 0-9]{18,18} internal/binary-amd64/Packages.gz
 [a-f0-9]{32}[ 0-9]{18,18} internal/binary-i386/Packages
 [a-f0-9]{32}[ 0-9]{18,18} internal/binary-i386/Packages.gz
SHA1:
 [a-f0-9]{40}[ 0-9]{18,18} internal/binary-amd64/Packages
 [a-f0-9]{40}[ 0-9]{18,18} internal/binary-amd64/Packages.gz
 [a-f0-9]{40}[ 0-9]{18,18} internal/binary-i386/Packages
 [a-f0-9]{40}[ 0-9]{18,18} internal/binary-i386/Packages.gz
SHA256:
 [a-f0-9]{64}[ 0-9]{18,18} internal/binary-amd64/Packages
 [a-f0-9]{64}[ 0-9]{18,18} internal/binary-amd64/Packages.gz
 [a-f0-9]{64}[ 0-9]{18,18} internal/binary-i386/Packages
 [a-f0-9]{64}[ 0-9]{18,18} internal/binary-i386/Packages.gz
SHA512:
 [a-f0-9]{128}[ 0-9]{18,18} internal/binary-amd64/Packages
 [a-f0-9]{128}[ 0-9]{18,18} internal/binary-amd64/Packages.gz
 [a-f0-9]{128}[ 0-9]{18,18} internal/binary-i386/Packages
 [a-f0-9]{128}[ 0-9]{18,18} internal/binary-i386/Packages.gz
EOS

  before(:each) do
    @repo_path = "/tmp/suppository_test_#{Time.now.to_f}"
    @dist = 'lucid'
    @instance = Suppository::Release.new(@repo_path, @dist, true)
    Suppository::CreateCommand.new([@repo_path]).run
    @release_file = "#{@repo_path}/dists/#{@dist}/Release"
    @release_file_gpg = "#{@release_file}.gpg"
  end

  after(:each) do
    FileUtils.rm_r @repo_path if File.exist? @repo_path
  end

  it 'has correct content' do
    @instance.create
    content = File.read(@release_file)
    puts content
    expect(Regexp.new(RELEASE_CONTENT).match content).to be_truthy
  end

  it 'creates file' do
    @instance.create
    expect(File.exist?(@release_file)).to eql true
  end

  it 'creates file' do
    @instance.create
    expect(File.exist?(@release_file)).to eql true
  end

  it 'unsigned' do
    @instance.create
    expect(File.exist?(@release_file_gpg)).to eql false
  end

  it 'signed' do
    command_runner = double(Suppository::CommandRunner)
    args = "-abs -o #{@release_file_gpg} #{@release_file}"
    expect(Suppository::CommandRunner).to receive(:new).with('gpg', args) { command_runner }
    expect(command_runner).to receive(:run) { FileUtils.touch(@release_file_gpg) }

    @instance = Suppository::Release.new(@repo_path, @dist)
    @instance.create
    expect(File.exist?(@release_file_gpg)).to eql true
  end
end
