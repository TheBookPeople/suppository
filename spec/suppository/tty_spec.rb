require 'rubygems'
require 'spec_helper'
require 'suppository/tty'

describe Suppository::Tty do
  
  describe 'gray' do
  
    it "Outputs returns nothing if not running in tty" do    
      expect($stdout).to receive(:tty?).and_return(false)
      expect(Suppository::Tty.gray).to be_nil
    end
  
    it "Returns if running in tty" do    
      expect($stdout).to receive(:tty?).and_return(true)
      expect(Suppository::Tty.gray).to eql "\e[1;30m"
    end
  
  end
  
  describe 'white' do
  
    it "Outputs returns nothing if not running in tty" do    
      expect($stdout).to receive(:tty?).and_return(false)
      expect(Suppository::Tty.white).to be_nil
    end
  
    it "Returns if running in tty" do    
      expect($stdout).to receive(:tty?).and_return(true)
      expect(Suppository::Tty.white).to eql "\e[1;39m"
    end
  
  end
  
  describe 'red' do
  
    it "Outputs returns nothing if not running in tty" do    
      expect($stdout).to receive(:tty?).and_return(false)
      expect(Suppository::Tty.red).to be_nil
    end
  
    it "Returns if running in tty" do    
      expect($stdout).to receive(:tty?).and_return(true)
      expect(Suppository::Tty.red).to eql "\e[4;31m"
    end
  
  end
  
  describe 'reset' do
  
    it "Outputs returns nothing if not running in tty" do    
      expect($stdout).to receive(:tty?).and_return(false)
      expect(Suppository::Tty.reset).to be_nil
    end
  
    it "Returns if running in tty" do    
      expect($stdout).to receive(:tty?).and_return(true)
      expect(Suppository::Tty.reset).to eql "\e[0m"
    end
  
  end
  
  describe 'green' do
  
    it "Outputs returns nothing if not running in tty" do    
      expect($stdout).to receive(:tty?).and_return(false)
      expect(Suppository::Tty.green).to be_nil
    end
  
    it "Returns if running in tty" do    
      expect($stdout).to receive(:tty?).and_return(true)
      expect(Suppository::Tty.green).to eql "\e[1;32m"
    end
  
  end
  
  describe 'em' do
  
    it "Outputs returns nothing if not running in tty" do    
      expect($stdout).to receive(:tty?).and_return(false)
      expect(Suppository::Tty.em).to be_nil
    end
  
    it "Returns if running in tty" do    
      expect($stdout).to receive(:tty?).and_return(true)
      expect(Suppository::Tty.em).to eql "\e[4;39m"
    end
  
  end 
end
  
  