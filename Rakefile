# -*- ruby -*-

require 'rubygems'
require 'hoe'

EDANGO_ROOT = File.expand_path(File.dirname(__FILE__))
require File.expand_path(File.join(EDANGO_ROOT, 'lib', 'edango'))

$hoe = Hoe.spec EDango::UNIX_NAME do
  self.version = EDango::VERSION
  self.developer EDango::AUTHOR, EDango::EMAIL
  self.url = EDango::URL

  self.readme_file = 'README.rdoc'
  self.post_install_message = File.read(File.expand_path(File.join(EDANGO_ROOT, 'PostInstall.txt'))) rescue ''

  self.extra_deps = [['sinatra',   '>= 0.9.4'],
                     ['haml',      '>= 2.2.16'],
                     ['mechanize', '>= 0.9.3']]
end

$hoe.spec.rdoc_options = ['--main', $hoe.readme_file, $hoe.readme_file]
$hoe.spec.extra_rdoc_files = ['History.txt']

# vim: syntax=ruby
