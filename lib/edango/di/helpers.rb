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

class Symbol
  unless method_defined?(:intern)
    define_method(:intern) do
      self.to_s().intern()
    end
  end
end

class File
  def self.prepare_directory(path)
    path = File.expand_path(path)

    Dir.mkdir(path) unless File.directory?(path) rescue nil

    path
  end
end

module Kernel
  def require_all(file, *files)
    (files << file).each { |item| require(item) }
  end
end
