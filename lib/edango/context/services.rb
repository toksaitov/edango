require 'edango/di/container'

module EDango

  SERVICES = DI::Container.new do
    service :environment do
      on_creation do
        require_all *FILES[:helpers]
        require 'edango/environment'

        Environment.instance()
      end

      interface :log_error do |instance, exception, message|
        instance.log_error(exception, message)
      end

      interface :log_warning do |instance, text|
        instance.log_warning(text)
      end

      interface :log_message do |instance, text|
        instance.log_message(text)
      end

      interface :show_message do |instance, text, log|
        instance.show_message(text, log)
      end
    end

    service :starter do
      on_creation do
        require 'edango/starter'; Starter.new()
      end

      interface :run do |instance|
        instance.run()
      end

      interface :usage do |instance|
        instance.options
      end
    end

    service :core do
      on_creation do
        require 'edango/site/core'; Core
      end

      interface :run do |instance|
        instance.run()
      end
    end

    service :executor do
      on_creation do
        require 'edango/executor'; Executor.new()
      end

      interface :run do |instance|
        instance.run()
      end
    end

    service :timer do
      on_creation do
        require 'timeout'; Timeout
      end
    end

    service :logic do
      on_creation do
        require 'edango/logic/ticket_extractor'

        TicketExtractor.new()
      end

      interface :process do |instance, *args|
        instance.extract_tickets(*args)
      end

      interface :errors do |instance|
        instance.errors
      end
    end

    service :web do
      on_creation do
        require 'sinatra/base'; Sinatra::Base
      end
    end

    service :agent do
      on_creation do
        require 'mechanize'

        WWW::Mechanize.new do |agent|
          agent.user_agent_alias = 'Windows Mozilla'
          agent.history.max_size = 0

          proxy = EDango::PARAMETERS[:options][:proxy]
          agent.set_proxy(*proxy) unless proxy.nil? or
                                         proxy[0].nil_or_empty? or
                                         proxy[1].nil_or_empty?
        end
      end
    end

    service :uri do
      on_creation do
        require 'uri'; URI
      end

      interface :host do |instance, uri|
        instance.parse(uri.to_s()).host.gsub(/^www\./, '') rescue ''
      end

      interface :valid? do |instance, uri|
        (instance.parse(uri.to_s()); true) rescue false
      end
    end

    service :logger do
      on_creation do
        require 'logger'

        logger = Logger.new(FILES[:log], 10, 1048576)
        logger.level = Logger::INFO

        logger
      end

      interface :error do |instance, message|
        message = message.inspect.strip()
        instance.error(message)
      end

      interface :warn do |instance, message|
        message = message.inspect.strip()
        instance.warn(message)
      end

      interface [:info, :put, :write, :<<] do |instance, message|
        message = message.inspect.strip()
        instance.info(message)
      end

      interface :flush do |instance| end
    end
  end

end
