# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'template_tree/version'

Gem::Specification.new do |spec|
  spec.name          = "template_tree"
  spec.version       = TemplateTree::VERSION
  spec.authors       = ["Simon Coffey"]
  spec.email         = ["simon@urbanautomaton.com"]
  spec.summary       = %q{Trace the template render tree in Rails}
  spec.description   = %q{Trace the template render tree in Rails}
  spec.homepage      = "https://github.com/urbanautomaton/template_tree"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.2.0"
end
