
require 'spec_helper'
require 'suppository/logger'

describe Suppository::Logger do
  describe 'log_error' do
    it 'decorated output tty? true' do
      expect($stdout).to receive(:tty?).twice.and_return(true)
      expect($stderr).to receive(:puts).with("\e[4;31mError\e[0m: Boom")
      Suppository::Logger.log_error 'Boom'
    end

    it 'simple output if tty? false' do
      expect($stdout).to receive(:tty?).twice.and_return(false)
      expect($stderr).to receive(:puts).with('Error: Boom')
      Suppository::Logger.log_error 'Boom'
    end
  end

  describe 'log_error' do
    it 'print to standard out' do
      expect(Suppository::Logger).to receive(:puts).with('Info Message')
      Suppository::Logger.log_info 'Info Message'
    end
  end

  describe 'log_verbose' do
    it 'decorated output tty? true' do
      expect($stdout).to receive(:tty?).twice.and_return(true)
      expect(Suppository::Logger).to receive(:puts).with("\e[1;30mVerbose Message\e[0m")
      Suppository::Logger.log_verbose 'Verbose Message'
    end

    it 'simple output if tty? false' do
      expect($stdout).to receive(:tty?).twice.and_return(false)
      expect(Suppository::Logger).to receive(:puts).with('Verbose Message')
      Suppository::Logger.log_verbose 'Verbose Message'
    end
  end

  describe 'log_success' do
    it 'decorated output tty? true' do
      expect($stdout).to receive(:tty?).exactly(3).times.and_return(true)
      expect(Suppository::Logger).to receive(:puts).with("\e[1;32m==>\e[1;39m Success Message\e[0m")
      Suppository::Logger.log_success 'Success Message'
    end

    it 'simple output if tty? false' do
      expect($stdout).to receive(:tty?).exactly(3).times.and_return(false)
      expect(Suppository::Logger).to receive(:puts).with('==> Success Message')
      Suppository::Logger.log_success 'Success Message'
    end
  end
end
