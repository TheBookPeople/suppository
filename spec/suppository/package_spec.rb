
require 'spec_helper'
require 'suppository/package'
require 'suppository/master_deb'

describe Suppository::Package do

EXPECTED_DESCRIPTION = <<-EOS
Description: Get a file from an HTTP, HTTPS or FTP server curl is a client to get files from servers using any of the supported
 protocols. The command is designed to work without user interaction
 or any kind of interactivity.
 .
 curl offers a busload of useful tricks like proxy support, user
 authentication, FTP upload, HTTP post, file transfer resume and more.

EOS
package_info = {
        'Package' => 'curl',
        'Version' => '7.22.0-3ubuntu4.11',
        'Architecture' => 'amd64',
        'Maintainer' => 'Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>',
        'Installed-Size' => '3450',
        'MD5sum' => 'e5ca0a9797acda4bfe8404524f0976b3',
        'SHA1' => 'b37ce9b17405d93c323c0b8bbe167c6f2dccfe02',
        'SHA256' => '5a315c56bc34f1ffed365f9aa50bbb36916e5a8fae8614f00d952983d4316555',
        'Section' => 'web',
        'Priority' => 'optional',
        'Homepage' => 'http://www.test.com/',
        'Description' => "Get a file from an HTTP, HTTPS or FTP server curl is a client to get files from servers using any of the supported\n protocols. The command is designed to work without user interaction\n or any kind of interactivity.\n .\n curl offers a busload of useful tricks like proxy support, user\n authentication, FTP upload, HTTP post, file transfer resume and more.",
        'Size' => '345'
      }

  before(:each) do
    deb = double(Suppository::MasterDeb)
    @instance = Suppository::Package.new('dists/trusty/internal/binary-amd64',deb)
	expect(deb).to receive(:filename) { 'curl_7.22.0-3ubuntu4.11_amd64.deb' }
    expect(deb).to receive(:full_attr) { package_info }
  end
    

  it "Outputs the Package" do
	desc = ''
	in_desc = false
  	@instance.content.split("\n").each do |line|
      k, v = line.split(': ')
      if k == 'Description' || in_desc
		in_desc = true
	  elsif k == 'Filename'
	  	  expect(v).to eql 'dists/trusty/internal/binary-amd64/curl_7.22.0-3ubuntu4.11_amd64.deb'
	  else
	  	  expect(package_info.key?(k)).to be_truthy
	  	  expect(package_info.value?(v)).to be_truthy
	  end

	  desc += line << "\n" if in_desc
	end
	desc << "\n"
    expect(desc).to eql EXPECTED_DESCRIPTION
  end
   
end
  
  
