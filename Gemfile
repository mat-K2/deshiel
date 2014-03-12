source 'http://rubygems.org'

gem 'rails', '3.1.3'

group :assets do
  gem 'sass-rails', '3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem "haml-rails"
gem 'devise'
gem 'jpmobile', '~> 2.0.5'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :production do
  gem 'pg'
  gem 'therubyracer-heroku'
end

group :development, :test do
  gem 'sqlite3'
  gem 'debugger'
end

group :development do
  gem 'heroku_san'
end

group :test do
  gem 'turn', '0.8.2', :require => false
end
