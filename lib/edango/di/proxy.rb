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
  module DI

    class Proxy
      class ProxyError < Exception; end

      instance_methods.each do |method|
        undef_method(method) unless method =~ /(^__|^send$|^object_id$)/
      end

      attr_reader :delegate, :interfaces

      def initialize(delegate, interfaces = {})
        @delegate   = delegate
        @interfaces = interfaces
      end

      def respond_to?(symbol, include_private=false)
        @delegate.respond_to?(symbol, include_private) ||
        @interfaces.has_key?(symbol)
      end

      private
      def method_missing(name, *args, &block)
        interface = @interfaces[name.intern()]

        unless interface.nil?
          interface.call(@delegate, *args, &block)
        else
          @delegate.send(name, *args, &block)
        end
      end
    end

  end
end
