
# frozen_string_literal: true

require 'spec_helper'
require 'suppository/help'

describe Suppository do
  EXPECTED = <<-EOS
  Example usage:

    suppository help
      - Display this Help message

    suppository version
      - Display version

    suppository create <REPOSITORY_PATH>
      - Create new empty repository in REPOSITORY_PATH

    suppository add <REPOSITORY_PATH> <DIST> <COMPONENT> <DEB_FILE> [--unsigned]
      - Add DEB_FILE to DIST and COMPONENT of repository at REPOSITORY_PATH

EOS
  it 'has usage string' do
    expect(Suppository.help).to eql(EXPECTED)
  end
end
