source 'http://rubygems.org'

gem 'rails', '~>3.2.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
#gem "picky"#, :git => "git://github.com/rogerbraun/picky.git", :branch => "yajl_encoding_workaround"
gem 'picky-client'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'sass-rails',   '~> 3.2.3'
gem 'jquery-rails'

gem 'newrelic_rpm'
gem "devise"
gem "formtastic"
gem "formtastic-bootstrap"
gem "kaminari"
gem "prawn"

group :import do
  gem "mysql2"
  gem "sequel"
end
gem "paper_trail", "~> 2"
gem "draper"
gem 'ledermann-rails-settings', :require => 'rails-settings'

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "rspec-rails"
  gem "capybara"
  gem "capybara-webkit"
  gem "selenium-webdriver"
  gem "thin"
  gem "pry"
  gem "libnotify"
  gem "mailcatcher"
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
#
group :deployment do
  gem 'capistrano'
  gem 'rvm-capistrano'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "guard-rspec"
  gem "capybara-webkit"
end
