# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rulers/version'

Gem::Specification.new do |spec|
  spec.name          = "rulers"
  spec.version       = Rulers::VERSION
  spec.authors       = ["Kavinder Dhaliwal"]
  spec.email         = ["kavinderd@gmail.com"]
  spec.summary       = %q{A Rack-based Web Framework}
  spec.description   = %q{Project accompanying Rebuilding Rails by Noah Gibbs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "erubis"
  spec.add_runtime_dependency "multi_json"
  spec.add_runtime_dependency "sqlite3"
  spec.add_development_dependency "rack-test"
  spec.add_runtime_dependency "pry"
  spec.add_runtime_dependency "pry-debugger"
 

end
