source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'execjs'
gem 'therubyracer'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'

group :production do
  # gems specifically for Heroku go here
  gem "sqlite3"
end

group :development do
  gem "sqlite3"
end

group :test do
  gem "sqlite3"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'devise'
gem 'omniauth-github'
#gem 'omniauth-sina'
gem 'omniauth-identity'
gem 'rspec-rails', :group => [:development, :test]
gem 'database_cleaner', :group => :test
gem 'factory_girl_rails', :group => :test
gem 'cucumber-rails', :group => :test
gem 'capybara', :group => :test
