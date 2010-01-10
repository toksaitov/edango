# -*- ruby -*-

require 'rubygems'
require 'hoe'

EDANGO_ROOT = File.expand_path(File.dirname(__FILE__))
require File.expand_path(File.join(EDANGO_ROOT, 'lib', 'edango'))

Hoe.spec EDango::UNIX_NAME do
  self.version = EDango::VERSION
  self.developer EDango::AUTHOR, EDango::EMAIL
  self.url = EDango::URL

  self.post_install_message = File.read(File.expand_path(File.join(EDANGO_ROOT, 'PostInstall.txt'))) rescue ''

  self.extra_deps = [['sinatra',   '>= 0.9.4'],
                     ['mechanize', '>= 0.9.3']]
end

# vim: syntax=ruby
