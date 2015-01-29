require 'spec_helper'
require 'suppository/version'
require 'English'

describe 'suppository binary' do
  before(:each) do
    @cmd = File.expand_path('./bin/suppository')
    @repository_path = "/tmp/suppository_test_#{Time.now.to_f}"
  end

  after(:each) do
    FileUtils.rm_r @repository_path if File.directory? @repository_path
  end

  it 'fails if no command is given' do
    output = `"#{@cmd}" 2>&1`
    expect($CHILD_STATUS.success?).to be_falsy
    expect(output).to include 'Error: Invalid usage'
  end

  describe 'create' do
    it 'creates folder without error' do
      `"#{@cmd}" create #{@repository_path}`
      expect($CHILD_STATUS.success?).to be_truthy
      expect(File.directory?("#{@repository_path}/dists")).to be_truthy
      expect(File.directory?(@repository_path)).to be_truthy
      expect(File.directory?("#{@repository_path}/.suppository")).to be_truthy
    end

    it 'fails if arguments invalid' do
      output = `"#{@cmd}" create 2>&1`
      expect($CHILD_STATUS.success?).to be_falsy
      expect(output).to include 'Error: Invalid usage'
    end
  end

  describe 'version' do
    it 'runs without error' do
      output = `"#{@cmd}" version`
      expect($CHILD_STATUS.success?).to be_truthy
      expect(output).to include "Suppository Version #{Suppository::VERSION}"
    end
  end

  describe 'help' do
    it 'runs without error' do
      output = `"#{@cmd}" help`
      expect($CHILD_STATUS.success?).to be_truthy
      expect(output).to include 'Example usage:'
    end
  end

  describe 'add' do
    it 'runs without error'  do
      `"#{@cmd}" create #{@repository_path}`
      `"#{@cmd}" add #{@repository_path} trusty internal "#{deb_file}" --unsigned`
      expect($CHILD_STATUS.success?).to be_truthy
      expect(File.file?("#{@repository_path}/dists/trusty/internal/binary-amd64/curl_7.22.0-3ubuntu4.11_amd64.deb")).to be_truthy
      expect(File.file?("#{@repository_path}/dists/trusty/internal/binary-i386/curl_7.22.0-3ubuntu4.11_amd64.deb")).to be_truthy
    end

    it 'fails if arguments invalid' do
      output = `"#{@cmd}" add #{@repository_path} trusty internal "#{deb_file} --unsigned" 2>&1`
      expect($CHILD_STATUS.success?).to be_falsy
      expect(output).to include "Error: #{@repository_path} is not a valid repository"
    end

    it 'fails if signing attempted (assumes no certificate)' do
      output = `"#{@cmd}" add #{@repository_path} trusty internal "#{deb_file}" 2>&1`
      expect($CHILD_STATUS.success?).to be_falsy
      expect(output).to include "Error: #{@repository_path} is not a valid repository"
    end
  end
end
