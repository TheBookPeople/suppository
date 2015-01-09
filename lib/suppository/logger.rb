
require 'suppository/tty'

module Suppository
  module Logger
    def log_info(message)
      puts message
    end

    def log_verbose(message)
      puts "#{Tty.gray}#{message}#{Tty.reset}"
    end

    def log_error(error)
      $stderr.puts "#{Tty.red}Error#{Tty.reset}: #{error}"
    end

    def log_success(message)
      puts "#{Tty.green}==>#{Tty.white} #{message}#{Tty.reset}"
    end

    module_function :log_info, :log_error, :log_success, :log_verbose
  end
end
