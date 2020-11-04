# frozen_string_literal: true

source 'https://rubygems.org'

gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rake'

gem 'rack-cors',    '~> 1.1'
gem 'rspotify',     '~> 2.4'
gem 'warden',       '~> 1.2'

gem 'pg'

group :development do
  gem 'hanami-webconsole'
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'byebug'
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'capybara'
  gem 'guard-rspec', require: false
  gem 'rspec'
end

group :production do
  # gem 'puma'
end
