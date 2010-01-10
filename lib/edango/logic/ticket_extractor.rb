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

  class TicketExtractor
    attr_reader :errors

    def initialize
      @environment = SERVICES[:environment]
      @options = @environment.options

      @timer = SERVICES[:timer]
      @time_limit = @options[:time_limit]

      @errors = []
    end

    def extract_tickets(url, passkey, specs)
      result = []

      @errors = []
      @agent  = SERVICES[:agent, :init]

      specs.each do |spec|
        errors_root = @errors

        @errors << [spec.first]
        @errors = @errors.last

        begin
          @timer.timeout(@time_limit) do
            result += extract_ticket(url, passkey, spec)
          end
        rescue Timeout::Error => e
          @errors << t(:operation_timed_out)
        end

        @errors = errors_root
        @errors.pop() if @errors.last.size == 1
      end

      if specs.empty?
        @errors.unshift([t(:all_specs), t(:no_specs_for_url)])
      end

      result
    end

    private
    def extract_ticket(target_url, passkey, specs)
      result = []

      specs = check_specs(specs)

      ticket_link_regex = specs[0]
      source_passkey = specs[1]

      login, password = specs[2]

      login_url = specs[3]

      valid? login(login_url, target_url, login, password) do
        ticket_link = find_ticket_link(target_url, ticket_link_regex)

        raw_ticket = save_raw_ticket(ticket_link)
        ticket = process_ticket(raw_ticket, source_passkey, passkey)

        result << ticket if ticket
      end

      result
    end

    def check_specs(specs)
      ticket_link_regex = check_spec(specs[1], :ticket_link_regex)
      passkey = check_spec(specs[2], :source_passkey)

      login, password = specs[3]

      login_url = check_spec(specs[4], :login_url)

      [ticket_link_regex, passkey, [login, password], login_url]
    end

    def check_spec(spec, error_key)
      result = spec

      if spec.nil_or_empty?
        @errors << t("empty_#{error_key}".intern())
        result = nil
      end

      result
    end

    def login(login_url, target_url, login, password)
      result = false

      if login_url and not login or not password
        @errors << t(:empty_login)    unless login
        @errors << t(:empty_password) unless password

        login_url = nil
      elsif not login_url and login and password
        login_url = target_url
      end

      if login_url
        begin
          @agent.get(login_url) do |page|
            form = page.forms.find { |form| form.action =~ /login/ }
            form.login_username = login
            form.login_password = password

            login_result = form.click_button()
            raise() unless login_result
          end
          result = true
        rescue Exception => e
          @errors << t(:login_process_failed)
          @environment.log_warning(e.message)
        end
      end

      result
    end

    def find_ticket_link(url, link_regex)
      result = nil

      valid? url, link_regex do
        begin
          link_regex = Regexp.new(link_regex)

          @agent.get(url) do |page|
            page.links.each do |link|
              (result = link; break) if link.href =~ link_regex
            end
          end

          unless result
            @errors << t(:ticket_link_not_found)
          end
        rescue Exception => e
          @errors << t(:ticket_page_loading_failed)
          @environment.log_warning(e.message)
        end
      end

      result
    end

    def save_raw_ticket(link)
      result = nil

      if link
        host  = SERVICES[:uri].host(link.page.uri)
        times = Time.now.strftime('%H-%M-%S_%m.%d.%Y')

        file = "raw_ticket_#{host}_#{times}"
        file = File.join(DIRS[:tickets], file)

        unique_name = file; number = 1
        while File.exists?("#{unique_name}.torrent")
          unique_name = "#{file}_#{number}"
          number += 1
        end

        file = "#{unique_name}.torrent"
        link.click().save_as(file) rescue nil

        unless File.exists?(file)
          @errors << t(:raw_ticket_not_saved)
        else
          result = file
        end
      end

      result
    end

    def process_ticket(path, source_passkey, passkey)
      result = nil

      valid? path, passkey, source_passkey do
        begin
          new_path = path.gsub('raw_', '')

          File.open(new_path, 'w+') do |writer|
            ticket = replace_passkey(read_raw_ticket(path), source_passkey, passkey)
            writer.binmode.write(ticket) if ticket
          end

          if File.exists?(new_path)
            result = new_path
          else
            raise()
          end
        rescue Exception => e
          @errors << t(:processed_ticket_not_saved)
          @environment.log_warning(e.message)
        end
      end

      result
    end

    def read_raw_ticket(path)
      result = nil

      begin
        File.open(path, 'r') do |io|
          result = io.binmode.read()
        end
      rescue Exception => e
        @errors << t(:raw_ticket_not_opened)
        @environment.log_warning(e.message)
      end

      result
    end

    def replace_passkey(raw_ticket, source_passkey, passkey)
      result = nil

      if raw_ticket
        ticket = raw_ticket.gsub(source_passkey, passkey)

        if ticket == raw_ticket
          if passkey != source_passkey
            @errors << t(:passkey_not_found)
          end
        else
          result = ticket
        end
      end

      result
    end
  end

end
