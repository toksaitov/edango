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

module EDango

  class Executor
    def initialize
      @environment = SERVICES[:environment]
      @tasks = @environment.tasks
    end

    def run
      if @tasks[:show_version]
        output_version()
      elsif @tasks[:show_help]
        output_help()
      else
        begin
          fake_stderr SERVICES[:logger] do
            SERVICES[:core].run!()
          end
        rescue Exception => e
          @environment.log_error(e, 'Core failure')
        end
      end
    end

    private
    def output_help
      output_version()
      output_options()
    end

    def output_version
      @environment.show_message("#{FULL_NAME} version #{VERSION}")
      @environment.show_message("#{COPYRIGHT}")
    end

    def output_options
      @environment.show_message("Available options: \n\n")
      @environment.show_message("Usage: #{UNIX_NAME} {[option] [parameter]}")

      SERVICES[:starter].usage.each do |name, options|
        @environment.show_message("\n\t#{options[2]}\n\t\t#{options[0]}, #{options[1]}")
      end
    end
  end

end
