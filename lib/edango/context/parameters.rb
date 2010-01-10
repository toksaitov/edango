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

  PARAMETERS = DI::Container.new do
    asset :options, :file => FILES[:options] do
      {:environment    => :production,
       :server_logging => true,
       :time_limit     => 10,
       :servers        => ['thin', 'mongrel', 'webrick'],
       :host           => '0.0.0.0',
       :port           => 6666,
       :sites          => []}
    end

    asset :modes, :file => FILES[:modes] do
      {:verbose => false,
       :quiet   => false,
       :debug   => false}
    end

    asset :tasks, :file => FILES[:tasks] do
      {:show_version => false,
       :show_help    => false}
    end
  end

end
