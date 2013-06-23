# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sql_dumper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joel Dubowy"]
  gem.email         = ["jdubowy@gmail.com"]
  gem.description   = %q{Adds sql dumping functionality to ActiveRecord objects}
  gem.summary       = %q{Adds sql dumping functionality to ActiveRecord objects}
  gem.homepage      = "https://github.com/jdubowy/sql_dumper"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sql_dumper"
  gem.require_paths = ["lib"]
  gem.version       = SqlDumper::VERSION
end
