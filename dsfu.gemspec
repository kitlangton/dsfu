# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dsfu/version'

Gem::Specification.new do |spec|
  spec.name          = "dsfu"
  spec.version       = Dsfu::VERSION
  spec.authors       = ["Kit Langton"]
  spec.email         = ["kitlangton@gmail.com"]
  spec.summary       = %q{A gem to make EFI's digital storefront more bearable.}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_dependency "thor"
  spec.add_dependency "capybara"
  spec.add_dependency "selenium-webdriver"
  spec.add_dependency "timeout"
  spec.add_dependency "terminal-table"
end
