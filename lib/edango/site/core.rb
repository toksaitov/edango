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

  class Core < SERVICES[:web, :raw]
    set :run,  true
    set :lock, true

    set :app_file, DIRS[:site]
    set :root,     DIRS[:site]

    set :public, DIRS[:public]
    set :views,  DIRS[:views]

    set :raise_errors, proc { test? }
    set :dump_errors,  proc { test? }

    enable :sessions
    enable :static
    enable :clean_trace

    disable :show_exceptions
    disable :methodoverride

    configure do
      EDango::SERVICES[:views_processor]

      set :options, EDango::SERVICES[:environment].options

      set :environment, (ENV['RACK_ENV'] || options[:environment]).intern()

      set :sites,  options[:sites]
      set :server, options[:servers]
      set :host,   options[:host]
      set :port,   options[:port]

      set :logging, options[:server_logging]

      Rack::Mime::MIME_TYPES['.torrent'] = 'application/x-bittorrent'

      options[:parameters].each do |param, value|
        self.class.set(param, value)
      end

      set :errors_list, {}
    end

    helpers do
      def error(key, value = nil)
        value ? options.errors_list[key] = value : options.errors_list[key]
      end
      alias err error

      def error?(key)
        options.errors_list[key] ? true : false
      end
      alias err? error?

      def clear_errors
        options.errors_list.clear()
      end

      def current_jlib
        options.environment == :production ? 'jquery.min.js' : 'jquery.js'
      end

      def url_input_class
        error?(:in_url) ? 'err-text' : 'normal-text'
      end

      def passkey_input_class
        error?(:in_passkey) ? 'err-text' : 'normal-text'
      end

      def emphasize(text, part = ':')
        text.gsub(part, "<em>#{part}</em>")
      end

      def sanitize(file_name)
        file_name.gsub(%r{\\|/|\.\.}, '') rescue ''
      end

      def link(ticket_path)
        "tickets/#{file(ticket_path)}"
      end

      def file(ticket_path)
        File.basename(File.expand_path(ticket_path))
      end

      def process_root
        @url = request.cookies['url']
        @passkey = request.cookies['passkey']

        haml(:index)
      ensure
        clear_errors()
      end

      def extract_tickets(url, passkey)
        unless url.nil_or_empty? or
               passkey.nil_or_empty?

          sites = options.sites.select do |item|
            url =~ Regexp.new(item.first) rescue false
          end

          logic  = EDango::SERVICES[:logic]
          result = logic.process(url, passkey, sites)

          unless logic.errors.empty?
            error :in_process, logic.errors
          end

          result
        end
      end
    end

    get '/' do
      process_root()
    end
    post '/' do
      process_root()
    end

    post '/process' do
      url, passkey = params[:url], params[:passkey]

      response.set_cookie('passkey', passkey)

      error :in_url,     t(:empty_url)     if url.nil_or_empty?
      error :in_passkey, t(:empty_passkey) if passkey.nil_or_empty?

      @tickets = extract_tickets(url, passkey)

      unless options.errors_list.empty?
        response.set_cookie('url', url)

        redirect('/')
      else
        response.delete_cookie('url')

        haml(:result)
      end
    end

    get '/tickets/:ticket' do
      file = File.join(EDango::DIRS[:tickets], sanitize(params[:ticket]))

      if File.directory?(file) or not File.exists?(file)
        error :in_process, [[t(:specified_file), t(:file_not_found)]]
      end

      unless options.errors_list.empty?
        redirect('/')
      else
        send_file(file)
      end
    end

    not_found do
      redirect('/')
    end

  end

end
