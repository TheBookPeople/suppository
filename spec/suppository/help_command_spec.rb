require 'rubygems'
require 'spec_helper'
require 'suppository/help_command'

describe Suppository::HelpCommand do
  
  it "shows help" do  
    command = Suppository::HelpCommand.new([])
    expect{command.run}.to output(Suppository.help).to_stdout
  end
  
end

