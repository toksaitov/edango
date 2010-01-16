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

require 'optparse'

module EDango

  class Starter
    SPECS =
      {:account_flag =>
         ['-a', '--account URL_REGEX,TICKET_LINK_REGEX,PASSKEY[,LOGIN:PASSWORD[,LOGIN_URL]]',
          'Adds account specifications used to obtain a ticket.'],
       :clear_flag =>
         ['-c', '--clear', 'Clear all account specifications from the configuration.'],
       :server_flag =>
         ['-s', '--server NAME:VALUE[,NAME:VALUE]', 'Specifies parameters for the "Sinatra" library.'],
       :proxy_flag =>
         ['-p', '--proxy HOST:PORT[:USER:PASSWORD]', 'Specifies proxy server parameters.'],
       :version_flag =>
         ['-v', '--version', 'Displays version information and exits.'],
       :help_flag =>
         ['-h', '--help', 'Displays this help message and exits.'],
       :quiet_flag =>
         ['-q', '--quiet', 'Starts in quiet mode.'],
       :verbose_flag =>
         ['-V', '--verbose', 'Starts in verbose mode (ignored in quiet mode).'],
       :debug_flag =>
         ['-d', '--debug', 'Starts in debug mode.']}

    def initialize
      @environment = SERVICES[:environment]

      @options = @environment.options
      @options[:parameters] ||= []

      @modes = @environment.modes
      @tasks = @environment.tasks

      @parser = OptionParser.new()
    end

    def run
      if options_parsed?()
        begin
          if @modes[:verbose]
            @environment.show_message("#{FULL_NAME} has started", :log)
          end

          SERVICES[:executor].run()

          if @modes[:verbose]
            @environment.show_message("#{FULL_NAME} has finished all tasks", :log)
          end
        rescue Exception => e
          @environment.log_error(e, 'Command line interface failure')
        end
      end

      GLOBALS[:errors_number] || 0
    end

    def options
      SPECS
    end

    private
    def options_parsed?
      result = false

      begin
        on_argument(:version_flag) { @tasks[:show_version] = true }
        on_argument(:help_flag)    { @tasks[:show_help]    = true }

        on_argument(:verbose_flag) do
          @modes[:verbose] = true if not @modes[:quiet]
        end
        on_argument(:quiet_flag) do
          @modes[:quiet]   = true
          @modes[:verbose] = false
        end
        on_argument(:debug_flag) do
          @modes[:debug] = true
        end

        on_argument(:account_flag) do |specs|
          specs = specs.split(',').map(&:strip) rescue []

          url_regex, ticket_link_regex, passkey, account, login_url = specs
          account = account.split(':').map(&:strip) if account

          @options[:sites] ||= []
          @options[:sites] << [url_regex, ticket_link_regex, passkey, account, login_url]

          @options[:sites].uniq!()
        end
        on_argument(:clear_flag) do
          @options[:sites] = []
        end

        on_argument(:server_flag) do |params|
          params = Hash[*params.split(',').map { |item| item.split(':').map(&:strip) }.flatten] rescue nil
          params.try(:intern_keys!)

          @options[:parameters] ||= []
          @options[:parameters] << params if params
        end

        on_argument(:proxy_flag) do |specs|
          specs = specs.split(':') rescue nil

          @options[:proxy] = nil
          if specs
            @options[:proxy] = specs unless specs[0].nil_or_empty? or
                                            specs[1].nil_or_empty?
          end
        end

        @parser.parse!(@environment.arguments)
        @environment.save_options(:all)

        result = true

      rescue Exception => e
        @environment.log_error(e, 'Failed to parse arguments')
      end

      result
    end

    def on_argument(name, &block)
      argument_key = name.intern()

      definition = SPECS[argument_key]
      @parser.on(*definition, &block)
    end
  end

end
