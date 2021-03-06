# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parlay_game_service/version'

Gem::Specification.new do |spec|
  spec.name          = "parlay_game_service"
  spec.version       = ParlayGameService::VERSION
  spec.authors       = ["Dmitry Khromov"]
  spec.email         = ["devandart@ya.ru"]
  spec.description   = %q{A simple Parlay Game Services ruby wrapper}
  spec.summary       = %q{A simple Parlay Game Services ruby wrapper}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "curb"
  spec.add_development_dependency "json"
  spec.add_development_dependency "rails"
end
