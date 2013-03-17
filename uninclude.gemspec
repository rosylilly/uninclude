# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uninclude/version'

Gem::Specification.new do |spec|
  spec.name          = "uninclude"
  spec.version       = Uninclude::VERSION
  spec.authors       = ["Sho Kusano"]
  spec.email         = ["rosylilly@aduca.org"]
  spec.description   = %q{Implement Module#uninclude and Object#unextend}
  spec.summary       = %q{Implement Module#uninclude and Object#unextend}
  spec.homepage      = "https://github.com/rosylilly/uninclude"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.extensions    = %w{ext/uninclude/extconf.rb}
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
