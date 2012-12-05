# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clean_css/version'

Gem::Specification.new do |gem|
  gem.name          = "clean_css"
  gem.version       = CleanCss::VERSION
  gem.authors       = ["SHIOYA, Hiromu"]
  gem.email         = ["kwappa.856@gmail.com"]
  gem.description   = %q{Ruby interface for clean-css (powered by node)}
  gem.summary       = %q{Ruby interface for clean-css (powered by node)}
  gem.homepage      = "https://github.com/kwappa/ruby-clean_css"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
