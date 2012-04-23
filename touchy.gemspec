# -*- encoding: utf-8 -*-
require File.expand_path('../lib/touchy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alessandro Morandi"]
  gem.email         = ["alessandro@dachisgroup.com"]
  gem.description   = %q{Touch an attribute of the Rails current user every time models are updated}
  gem.summary       = %q{Touch Rails current user on model updates}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "touchy"
  gem.require_paths = ["lib"]
  gem.version       = Touchy::VERSION
  
  gem.add_development_dependency('rake', '~> 0.9')
  gem.add_development_dependency('rspec', '~> 2.9')
  gem.add_development_dependency('sqlite3', '~> 1.3')
  gem.add_development_dependency('database_cleaner', '~> 0.7')
  # See http://blog.wyeworks.com/2011/11/1/ruby-1-9-3-and-ruby-debug for info on getting
  #  ruby-debug working with Ruby 1.9.3-p0
  gem.add_development_dependency('ruby-debug19', '~> 0.11')
  gem.add_development_dependency('factory_girl', '~> 3.1')
  gem.add_development_dependency('activerecord', '~> 3.2')
  
  gem.add_runtime_dependency('activesupport', '~> 3.2')
end
