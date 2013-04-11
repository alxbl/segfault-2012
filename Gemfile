source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'redcarpet'

group :development, :test do
  gem 'rspec-rails'
  gem 'minitest'
  gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails'
end

# Yeah, SQLite everywhere.
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :production do
  gem 'passenger', '4.0.0rc4'
  gem 'rspec' # rspec-rails won't pull it.
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
