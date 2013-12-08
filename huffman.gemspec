# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huffman/version'

Gem::Specification.new do |spec|
  spec.name          = "huffman"
  spec.version       = Huffman::VERSION
  spec.authors       = ["Martin Lagrange", "Bastien Jorge"]
  spec.email         = ["lagrangemartin@gmail.com", "bastien.jorge@utt.fr"]
  spec.summary       = %q{Algorithme de Huffman}
  spec.description   = %q{Algorithme de Huffman}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  
  spec.add_dependency "activesupport"
  spec.add_dependency "ruby-graphviz"
end
