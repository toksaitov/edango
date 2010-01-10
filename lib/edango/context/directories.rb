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

require 'edango/di/container'

module EDango

  DIRECTORIES = DI::Container.new do
    asset :base do
      File.prepare_directory(File.join('~', ".#{UNIX_NAME}"))
    end

    asset :helpers do
      File.expand_path(File.join(File.dirname(__FILE__), '..', 'helpers'))
    end

    asset :site do
      File.expand_path(File.join(File.dirname(__FILE__), '..', 'site'))
    end

    asset :views do
      File.join(DIRECTORIES[:site], 'views')
    end

    asset :public do
      File.join(DIRECTORIES[:site], 'public')
    end

    asset :styles do
      File.join(DIRECTORIES[:public], 'styles')
    end

    asset :scripts do
      File.join(DIRECTORIES[:public], 'scripts')
    end

    asset :images do
      File.join(DIRECTORIES[:public], 'images')
    end

    asset :tickets do
      File.prepare_directory(File.join(DIRECTORIES[:base], 'tickets'))
    end

    asset :log do
      File.prepare_directory(File.join(DIRECTORIES[:base], 'logs'))
    end
  end

  DIRS = DIRECTORIES

end
