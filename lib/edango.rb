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

current_dir = File.dirname(__FILE__)
current_abs_path = File.expand_path(current_dir)

$LOAD_PATH.unshift(current_dir) unless $LOAD_PATH.include?(current_dir) or
                                       $LOAD_PATH.include?(current_abs_path)

module EDango
  FULL_NAME = 'EDango'
  UNIX_NAME = 'edango'
  VERSION   = '0.5.1'

  AUTHOR = 'Toksaitov Dmitrii Alexandrovich'

  EMAIL = "toksaitov.d@gmail.com"
  URL   = "http://github.com/toksaitov/#{UNIX_NAME}/"

  COPYRIGHT = "Copyright (C) 2010 #{AUTHOR}"

  USER_BASE_DIRECTORY = ENV["#{UNIX_NAME.upcase()}_USER_BASE"] || File.join('~', ".#{UNIX_NAME}")

  GLOBALS = {}
end

require 'edango/context'
