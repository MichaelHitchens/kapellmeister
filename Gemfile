source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '3.1.1'

gemspec

gem 'dry-schema'
gem 'faraday'

# debug
group :development do
  gem 'byebug'
  gem 'web-console'
  gem 'listen'
  gem 'rerun', git: 'https://github.com/alexch/rerun.git'
end

# listings
group :development, :test do
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'rubycritic', '~> 4.9.1', require: false
  gem 'ruby_gntp'
end
