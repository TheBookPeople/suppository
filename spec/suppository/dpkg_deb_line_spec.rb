
# frozen_string_literal: true

require 'spec_helper'
require 'suppository/dpkg_deb_line'

describe Suppository::DpkgDebLine do
  it 'field' do
    line = 'Depends: libc6 (>= 2.14), libcurl3 (>= 7.16.2-1), zlib1g (>= 1:1.1.4)'
    values = Suppository::DpkgDebLine.new(line).attributes
    expect(values['Depends']).to eql 'libc6 (>= 2.14), libcurl3 (>= 7.16.2-1), zlib1g (>= 1:1.1.4)'
  end

  it 'description first line' do
    line = 'Description: Get a file from an HTTP, HTTPS or FTP server'
    values = Suppository::DpkgDebLine.new(line).attributes
    expect(values['Description']).to eql 'Get a file from an HTTP, HTTPS or FTP server'
  end

  it 'description other line' do
    line = ' curl is a client to get files from servers using any of the supported'
    values = Suppository::DpkgDebLine.new(line).attributes
    expect(values['Description']).to eql ' curl is a client to get files from servers using any of the supported'
  end

  it 'dot' do
    line = ' .'
    values = Suppository::DpkgDebLine.new(line).attributes
    expect(values['Description']).to eql ' .'
  end

  it 'handles invalid' do
    expect(get_exception { Suppository::DpkgDebLine.new 'Boom Bang' }).to eql "can't parse line - 'Boom Bang'"
  end
end
