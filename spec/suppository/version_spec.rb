
# frozen_string_literal: true

require 'spec_helper'
require 'suppository/version'

describe Suppository do
  it 'has a version number' do
    expect(Suppository::VERSION.length).to be > 0
  end
end
