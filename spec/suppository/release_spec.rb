require 'rubygems'
require 'spec_helper'
require 'suppository/release'
require 'suppository/create_command'

describe Suppository::Release do

EXPECTED_CONTENT = <<-EOS
Codename: lucid
Architectures: amd64 i386
Components: internal
Date: Tue, 06 Jan 2015 00:43:13 GMT
MD5Sum:
 d41d8cd98f00b204e9800998ecf8427e                 0 dists/lucid/internal/binary-amd64/Packages
 2f3e2442476f5464c314716ef684c02c               103 dists/lucid/internal/binary-amd64/Packages.gz
 d41d8cd98f00b204e9800998ecf8427e                 0 dists/lucid/internal/binary-i386/Packages
 7c0c23a67294ee276556e2f7f0ad5bc2               102 dists/lucid/internal/binary-i386/Packages.gz
SHA1:
 da39a3ee5e6b4b0d3255bfef95601890afd80709                 0 dists/lucid/internal/binary-amd64/Packages
 3e9ac8f4be976f1c6a52c13a3a251dfec7c204e7               103 dists/lucid/internal/binary-amd64/Packages.gz
 da39a3ee5e6b4b0d3255bfef95601890afd80709                 0 dists/lucid/internal/binary-i386/Packages
 14934aa27c0ea7148d5b94b0ff3c769cfa59a297               102 dists/lucid/internal/binary-i386/Packages.gz
SHA256:
 e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855                 0 dists/lucid/internal/binary-amd64/Packages
 bce970b56be93d9280b806bf630b3c85332293212002dcb38eb9911c6dcd725c               103 dists/lucid/internal/binary-amd64/Packages.gz
 e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855                 0 dists/lucid/internal/binary-i386/Packages
 6e2679e057b8b9fa202677d114914fb9d67d378445449983fc432c27becedc38               102 dists/lucid/internal/binary-i386/Packages.gz
SHA512:
 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e                 0 dists/lucid/internal/binary-amd64/Packages
 8c5a6c5573e2b5e6e187cb8aa85a7d5cdbc941ba2dfbc705fb33404a643d5ddee64014a4a9d094151400ce4ac58946bff52e53e4b922485f06405637ab9e080b               103 dists/lucid/internal/binary-amd64/Packages.gz
 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e                 0 dists/lucid/internal/binary-i386/Packages
 2a977dcc902cb6105c5981d114fb5759b8bd3a0805b30d70b2b519ad17fed233a1bd62b5b705b187ac31ea6e3def0fa598c0731281e8be2de513757d5190be14               102 dists/lucid/internal/binary-i386/Packages.gz  

EOS
  
  
  before(:each) do
    @repo_path = "/tmp/suppository_test_#{Time.now.to_f}"
    @dist = 'lucid'
    @instance = Suppository::Release.new(@repo_path, @dist)
    Suppository::CreateCommand.new([@repo_path]).run
  end
  
  after(:each) do
    FileUtils.rm_r @repo_path if File.exist? @repo_path
  end
  
  it "creates file"# , :focus=>true do
#     @instance.create
#     releases_path = "#{@repo_path}/dists/#{@dist}/Release"
#     expect(File.read(releases_path)).to match EXPECTED_CONTENT
#   end
  
end