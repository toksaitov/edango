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

  FILES = DI::Container.new do
    asset :log do
      File.join(DIRECTORIES[:log], 'application.log')
    end

    asset :options do
      File.join(DIRECTORIES[:base], 'options.yml')
    end

    asset :modes do
      File.join(DIRECTORIES[:base], 'modes.yml')
    end

    asset :tasks do
      File.join(DIRECTORIES[:base], 'tasks.yml')
    end

    asset :helpers do
      Dir[File.join(DIRECTORIES[:helpers], '**', '*.rb')]
    end
  end

end
