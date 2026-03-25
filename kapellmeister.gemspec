lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kapellmeister/version'

Gem::Specification.new do |gem|
  gem.name          = 'kapellmeister'
  gem.version       = Kapellmeister::VERSION
  gem.authors       = %w[DarkWater]
  gem.email         = %w[denis.arushanov@darkcreative.ru]

  gem.summary       = 'HTTP requests dispatcher'
  gem.description   = 'Contains third party routes parser'
  gem.homepage      = 'https://github.com/DarkWater666/kapellmeister'

  gem.license       = 'MIT'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless gem.respond_to?(:metadata)

  gem.metadata['allowed_push_host'] = 'https://rubygems.org'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(/^(test|spec|features)/) }
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(/^exe/) { |f| File.basename(f) }
  gem.require_paths = %w[lib]

  gem.required_ruby_version = '>= 2.4.2'

  gem.add_dependency 'dry-schema', '< 1.13'
  gem.add_dependency 'faraday', '>= 0.17', '< 2'
  gem.add_dependency 'faraday-cookie_jar', '~> 0.0.7'

  gem.add_development_dependency 'bundler', '~> 2.0', '>= 2.0.2'
  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'redcarpet', '~> 1.17', '>= 1.17.0'
  gem.add_development_dependency 'rubocop', '~> 1.6'
  gem.add_development_dependency 'yard', '~> 0.7', '>= 0.7.5'
  gem.metadata['rubygems_mfa_required'] = 'true'
end
