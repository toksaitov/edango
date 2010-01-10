#    EDango - torrent ticket extractor.
#    Copyright (C) 2010  Dmitrii Toksaitov
#
#    This file is part of EDango.
#
#    EDango is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    EDango is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with EDango. If not, see <http://www.gnu.org/licenses/>.

require 'singleton'

module EDango

  class Environment
    include Singleton

    attr_reader :arguments

    attr_reader :logger
    attr_reader :options, :modes, :tasks

    def initialize
      @arguments = ARGV

      @logger  = SERVICES[:logger]

      @options = PARAMETERS[:options]
      @modes   = PARAMETERS[:modes]
      @tasks   = PARAMETERS[:tasks]
    end

    def log_error(exception, message)
      @logger.error(message)
      @logger.error(exception.message)

      unless @modes.nil?
        @logger.error(exception.backtrace) if @modes[:verbose] or
                                              @modes[:debug]
      end

      GLOBALS[:errors_number] ||= 0
      GLOBALS[:errors_number] += 1
    end

    def log_warning(text)
      @logger.warn(text)
    end

    def log_message(text)
      @logger.info(text)
    end

    def show_message(message, log = false)
      puts(message) unless @modes[:quiet]
      log_message(message) if log
    end

    def state(message)
      puts(message) if @modes[:verbose]
      log_message(message)
    end

    def save_options(*args)
      PARAMETERS.update(*args)
    end
  end

end
