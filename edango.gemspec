# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name = %q{edango}
  spec.version = "0.5.1"

  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=
  spec.authors = ["Toksaitov Dmitrii Alexandrovich"]
  spec.date = %q{2010-01-10}
  spec.default_executable = %q{edango}
  spec.description = %q{Evil Dango is a small Ruby application that can extract torrent tickets from 'torrentpier'-enabled sites.

It fetches a ticket with a predefined account and replaces the initial passkey with the new defined one.}
  spec.email = ["toksaitov.d@gmail.com"]
  spec.executables = ["edango"]
  spec.extra_rdoc_files = ["Copying.txt", "History.txt", "Manifest.txt", "PostInstall.txt", "README.txt"]
  spec.files = ["Copying.txt", "History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "README.txt", "Rakefile", "bin/edango", "lib/edango.rb", "lib/edango/context.rb", "lib/edango/context/directories.rb", "lib/edango/context/files.rb", "lib/edango/context/language.rb", "lib/edango/context/parameters.rb", "lib/edango/context/services.rb", "lib/edango/di/container.rb", "lib/edango/di/helpers.rb", "lib/edango/di/proxy.rb", "lib/edango/di/service.rb", "lib/edango/di/service_factory.rb", "lib/edango/environment.rb", "lib/edango/executor.rb", "lib/edango/helpers/hash.rb", "lib/edango/helpers/kernel.rb", "lib/edango/helpers/object.rb", "lib/edango/helpers/string.rb", "lib/edango/helpers/symbol.rb", "lib/edango/logic/ticket_extractor.rb", "lib/edango/site/core.rb", "lib/edango/site/public/favicon.ico", "lib/edango/site/public/images/btn-back-help.png", "lib/edango/site/public/images/bullet.png", "lib/edango/site/public/images/ctrl-back.gif", "lib/edango/site/public/images/frm-back-err.png", "lib/edango/site/public/images/frm-back-help.png", "lib/edango/site/public/images/frm-back.png", "lib/edango/site/public/images/logo.png", "lib/edango/site/public/scripts/jquery.js", "lib/edango/site/public/scripts/jquery.min.js", "lib/edango/site/public/scripts/logic.js", "lib/edango/site/public/styles/layout.css", "lib/edango/site/views/errors.haml", "lib/edango/site/views/help.haml", "lib/edango/site/views/index.haml", "lib/edango/site/views/layout.haml", "lib/edango/site/views/result.haml", "lib/edango/starter.rb"]
  spec.homepage = %q{http://github.com/toksaitov/edango/}
  spec.post_install_message = %q{Thank you for installing the Evil Dango application

Please be sure to read README.txt and History.txt
for useful information about this release.

For more info, visit http://github.com/toksaitov/edango}
  spec.rdoc_options = ["--main", "README.txt"]
  spec.require_paths = ["lib"]
  spec.rubyforge_project = %q{edango}
  spec.rubygems_version = %q{1.3.5}
  spec.summary = %q{Evil Dango is a small Ruby application that can extract torrent tickets from 'torrentpier'-enabled sites}

  if spec.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    spec.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      spec.add_runtime_dependency(%q<sinatra>, [">= 0.9.4"])
      spec.add_runtime_dependency(%q<mechanize>, [">= 0.9.3"])
      spec.add_development_dependency(%q<rubyforge>, [">= 2.0.3"])
      spec.add_development_dependency(%q<gemcutter>, [">= 0.3.0"])
      spec.add_development_dependency(%q<hoe>, [">= 2.5.0"])
    else
      spec.add_dependency(%q<sinatra>, [">= 0.9.4"])
      spec.add_dependency(%q<mechanize>, [">= 0.9.3"])
      spec.add_dependency(%q<rubyforge>, [">= 2.0.3"])
      spec.add_dependency(%q<gemcutter>, [">= 0.3.0"])
      spec.add_dependency(%q<hoe>, [">= 2.5.0"])
    end
  else
    spec.add_dependency(%q<sinatra>, [">= 0.9.4"])
    spec.add_dependency(%q<mechanize>, [">= 0.9.3"])
    spec.add_dependency(%q<rubyforge>, [">= 2.0.3"])
    spec.add_dependency(%q<gemcutter>, [">= 0.3.0"])
    spec.add_dependency(%q<hoe>, [">= 2.5.0"])
  end
end
