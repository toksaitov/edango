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

class Object
  def valid?(item, *args, &block)
    result = item ? true : false

    if result
      args.each do |object|
        (result = false; break) unless object
      end

      yield if block_given?
    end

    result
  end

  def try(method_name, *args, &block)
    send(method_name, *args, &block) if respond_to?(method_name, true)
  end

  def nil_or_empty?
    nil? or try(:empty?)
  end

  unless method_defined?(:instance_exec)

    module InstanceExecHelper; end
    include InstanceExecHelper

    #noinspection RubyScope,RubyDeadCode
    def instance_exec(*args, &block)
      method_name = "__instance_exec_#{Thread.current.object_id.abs}_#{object_id.abs}"

      InstanceExecHelper.module_eval { define_method(method_name, &block) }

      result = nil

      begin
        result = send(method_name, *args)
      ensure
        InstanceExecHelper.module_eval { undef_method(method_name) } rescue nil
      end

      result
    end

  end
end
