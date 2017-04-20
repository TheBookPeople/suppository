# frozen_string_literal: true

require 'suppository/help'

module Suppository
  class HelpCommand
    def initialize(_); end

    def run
      puts Suppository.help
    end
  end
end
