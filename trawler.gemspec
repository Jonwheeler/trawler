# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trawler/version'

Gem::Specification.new do |spec|
  spec.name          = "trawler"
  spec.version       = Trawler::VERSION
  spec.authors       = ["Jon Wheeler"]
  spec.email         = ["jon@doejo.com"]
  spec.description   = %q{Scrapes the web}
  spec.summary       = %q{Scrape a url for images, video links and meta descriptions}
  spec.homepage      = %q{https://github.com/Jonwheeler/trawler}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri",              "~> 1.6"
  spec.add_dependency "hashr",                 "~> 0.0.22"

  spec.add_development_dependency "bundler",   "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec",     "~> 2.14"
  spec.add_development_dependency "webmock",   "~> 1.14"
  spec.add_development_dependency "vcr",       "~> 2.6"
  spec.add_development_dependency "simplecov", "~> 0.7"
end
