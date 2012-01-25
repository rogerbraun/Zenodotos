source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem "picky", :git => "git://github.com/rogerbraun/picky.git", :branch => "yajl_encoding_workaround"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'sass-rails',   '~> 3.1.4'
gem 'jquery-rails'

gem "activeadmin"
gem "kaminari"
gem "prawn"
gem "mysql2"
gem "sequel"
gem "paper_trail", "~> 2"

group :development do
  gem "thin"
  gem "pry"
  gem "rspec-rails"
  gem "capybara"
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

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "guard-rspec"
  gem "nyan-cat-formatter"
end
