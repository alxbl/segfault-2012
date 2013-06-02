source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'redcarpet'
gem 'will_paginate'

gem 'capistrano'
gem 'rvm-capistrano'

group :development, :test do
  gem 'rspec-rails'
  gem 'minitest'
  gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork'
  gem 'sqlite3'
  gem 'factory_girl'
  gem 'factory_girl_rails'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :production do
  gem 'passenger', '4.0.0rc4'
  gem 'pg'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
