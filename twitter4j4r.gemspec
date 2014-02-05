# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twitter4j4r/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tobias Crawley", "Marek Jelen", "Gregory Ostermayr"]
  gem.email         = ["toby@tcrawley.org"]
  gem.description   = %q{A thin, woefully inadequate wrapper around http://twitter4j.org/}
  gem.summary       = %q{A thin, woefully inadequate wrapper around http://twitter4j.org/ that only supports the stream api with keywords.}
  gem.homepage      = "https://github.com/tobias/twitter4j4r"

  gem.platform      = "java"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twitter4j4r"
  gem.require_paths = ["lib"]
  gem.version       = Twitter4j4r::VERSION
end
