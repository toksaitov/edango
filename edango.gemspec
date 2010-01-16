# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{edango}
  s.version = "0.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Toksaitov Dmitrii Alexandrovich"]
  s.date = %q{2010-01-17}
  s.default_executable = %q{edango}
  s.description = %q{Evil Dango is a small Ruby application that can extract torrent tickets from 'torrentpier'-enabled sites.

It fetches a ticket with a predefined account and replaces the initial passkey with the new defined one.}
  s.email = ["toksaitov.d@gmail.com"]
  s.executables = ["edango"]
  s.extra_rdoc_files = ["History.txt"]
  s.files = ["Copying.txt", "History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "bin/edango", "lib/edango.rb", "lib/edango/context.rb", "lib/edango/context/directories.rb", "lib/edango/context/files.rb", "lib/edango/context/language.rb", "lib/edango/context/parameters.rb", "lib/edango/context/services.rb", "lib/edango/di/container.rb", "lib/edango/di/helpers.rb", "lib/edango/di/proxy.rb", "lib/edango/di/service.rb", "lib/edango/di/service_factory.rb", "lib/edango/environment.rb", "lib/edango/executor.rb", "lib/edango/helpers/hash.rb", "lib/edango/helpers/kernel.rb", "lib/edango/helpers/object.rb", "lib/edango/helpers/string.rb", "lib/edango/helpers/symbol.rb", "lib/edango/logic/ticket_extractor.rb", "lib/edango/site/core.rb", "lib/edango/site/public/favicon.ico", "lib/edango/site/public/images/btn-back-help.png", "lib/edango/site/public/images/bullet.png", "lib/edango/site/public/images/ctrl-back.gif", "lib/edango/site/public/images/frm-back-err.png", "lib/edango/site/public/images/frm-back-help.png", "lib/edango/site/public/images/frm-back.png", "lib/edango/site/public/images/logo.png", "lib/edango/site/public/scripts/jquery.js", "lib/edango/site/public/scripts/jquery.min.js", "lib/edango/site/public/scripts/logic.js", "lib/edango/site/public/styles/layout.css", "lib/edango/site/views/errors.haml", "lib/edango/site/views/help.haml", "lib/edango/site/views/index.haml", "lib/edango/site/views/layout.haml", "lib/edango/site/views/result.haml", "lib/edango/starter.rb"]
  s.homepage = %q{http://github.com/toksaitov/edango/}
  s.post_install_message = %q{Thank you for installing the Evil Dango application

Please be sure to read README.rdoc and History.txt
for useful information about this release.

For more info, visit http://github.com/toksaitov/edango
}
  s.rdoc_options = ["--main", "README.rdoc", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{edango}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Evil Dango is a small Ruby application that can extract torrent tickets from 'torrentpier'-enabled sites}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_runtime_dependency(%q<haml>, [">= 2.2.16"])
      s.add_runtime_dependency(%q<mechanize>, [">= 0.9.3"])
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.3"])
      s.add_development_dependency(%q<gemcutter>, [">= 0.3.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.5.0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_dependency(%q<haml>, [">= 2.2.16"])
      s.add_dependency(%q<mechanize>, [">= 0.9.3"])
      s.add_dependency(%q<rubyforge>, [">= 2.0.3"])
      s.add_dependency(%q<gemcutter>, [">= 0.3.0"])
      s.add_dependency(%q<hoe>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0.9.4"])
    s.add_dependency(%q<haml>, [">= 2.2.16"])
    s.add_dependency(%q<mechanize>, [">= 0.9.3"])
    s.add_dependency(%q<rubyforge>, [">= 2.0.3"])
    s.add_dependency(%q<gemcutter>, [">= 0.3.0"])
    s.add_dependency(%q<hoe>, [">= 2.5.0"])
  end
end
