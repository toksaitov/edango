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

require 'yaml'

require 'edango/di/helpers'

require 'edango/di/proxy'
require 'edango/di/service_factory'

module EDango
  module DI

    class Container
      class TrapError < Exception; end

      attr_reader :services

      def initialize(&block)
        @services = {}
        @current_service = nil

        instance_eval(&block) if block_given?
      end

      def service(name, &block)
        @current_service = name

        instance_eval(&block) if block_given?

        @current_service = nil
      end

      def on_creation(&block)
        asset(@current_service, &block)
      end

      def asset(arg, options = {}, &block)
        name, instance = arg, nil

        if arg.is_a?(Hash)
          name, instance = arg.to_a().first
        end

        path = options[:file]
        if path
          instance = (YAML.load_file(path) rescue nil) || instance
        end

        if instance or block_given?
          service = find_service(name)

          service[:block]    = block
          service[:instance] = instance
          service[:file]     = path
        end
      end

      def interface(args, service_name = nil, &block)
        service_name ||= @current_service

        if block_given?
          args = [args] unless args.is_a?(Array)

          args.each do |name|
            service = find_service(service_name)
            service[:interfaces][name.intern()] = block if service
          end
        end
      end

      def [](name, option = nil)
        result = nil

        service_name = name.intern()
        service = @services[service_name]

        if service
          result = service[:instance]
          if result.nil? or option == :init
            instance = service[:block].call()
            if instance
              result = service[:instance] =
                Proxy.new(instance, service[:interfaces])
            end
          end
        end

        option == :raw ? result.delegate : result
      end

      def update(arg, file = nil)
        services = if arg.is_a?(Symbol)
          if arg == :all
            file = nil; @services.values
          else
            [find_service(arg.intern())]
          end
        else
          [arg]
        end

        services.each do |service|
          serialize(service, file) if service
        end
      end

      private
      def serialize(service, file = nil)
        path = file || service[:file]
        instance = service[:instance]

        if path and instance
          begin
            File.open(path, 'w+') do |io|
              io.write(instance.to_yaml())
            end
          rescue Exception => e
            puts("DI container failed to serialize service to #{path}")
            puts(e.message, e.backtrace)
          end
        end
      end

      def find_service(name)
        result = nil

        if name
          service_name = name.intern()

          result = @services[service_name]
          unless result
            new_service = DummyServiceFactory.service
            new_service.add_observer(self)

            result = @services[service_name] = new_service
          end
        end

        result
      end
    end

  end
end
