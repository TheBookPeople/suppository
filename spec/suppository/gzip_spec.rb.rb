
require 'spec_helper'
require 'suppository/gzip'

describe Suppository::Gzip do
  before(:each) do
    @file = "/tmp/gzip_test_#{Time.now.to_f}.txt"
    @file_gz = "#{@file}.gz"
  end

  after(:each) do
    FileUtils.rm @file if File.exist? @file
    FileUtils.rm @file_gz if File.exist? @file_gz
  end

  it 'compress' do
    Suppository::Gzip.compress @file
    expect(Zlib::GzipReader.open(@file_gz)).to be_truthy
  end
end
