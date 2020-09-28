source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'

gem 'rspotify',     '~> 2.4'
gem 'warden',       '~> 1.2'
gem 'rack-cors',    '~> 1.1'

gem 'pg'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'byebug'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'guard-rspec', require: false
end

group :production do
  # gem 'puma'
end
