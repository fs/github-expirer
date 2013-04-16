# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'expirer/version'

Gem::Specification.new do |spec|
  spec.name          = 'github-expirer'
  spec.version       = Expirer::VERSION
  spec.authors       = ['Timur Vafin']
  spec.email         = ['timur.vafin@flatstack.com']
  spec.description   = %q{A quick hack to produce a list of not used repositories at Github.}
  spec.summary       = %q{A quick hack to produce a list of not used repositories at Github.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'github_api'
  spec.add_dependency 'chronic'
  spec.add_dependency 'ansi'
  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'timecop'
end
