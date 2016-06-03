source 'https://rubygems.org'

ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 3.0.0', github: 'rails/turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'simple_form', '~> 3.1.0'
gem 'nested_form'
gem 'tabs_on_rails', '~> 2.1.1'
gem 'figaro', '~> 1.0.0', github: 'laserlemon/figaro'
gem 'sorcery', '~> 0.9.1'
gem 'omniauth-centralid', '~> 0.1.0' #, path: '../../centralid/omniauth-centralid'
gem 'identicon'
gem 'rack-cors', require: 'rack/cors'
gem 'hirb'
gem 'ffaker'
gem 'six'
gem 'pg_search', '~> 1.0.2'
gem 'kaminari', '~> 1.0.0.alpha', github: 'amatsuda/kaminari'
gem 'sinatra', '>= 1.3.0', require: nil # required to access sidekiq UI
gem 'sidekiq', '~> 3.3.0'

group :test do
  gem 'minitest-rails-capybara'
  gem 'minitest-reporters'
end

group :development do
  gem 'spring'
  gem 'rack-mini-profiler'
  gem 'letter_opener'
  gem 'better_errors', '~> 2.0'
  gem 'web-console', '~> 2.0'
  gem 'rails-erd'
  gem 'byebug'
  gem 'capistrano', '~> 2.15.5'
  gem 'foreman', require: false
end

group :development, :test do
  gem 'thin', require: false
end

group :production do
  gem 'exception_notification', '~> 4.0.0'
  gem 'unicorn'
  gem 'rails_12factor'
end
