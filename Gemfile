source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
# gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

gem 'thin'
gem 'simple_form', '~> 3.2.0'
gem 'nested_form'
# gem 'tabs_on_rails', '~> 2.2'
gem 'figaro', '~> 1.1.1', github: 'laserlemon/figaro'
gem 'sorcery', '~> 0.9.1'
gem 'omniauth-centralid', '~> 0.1.0' #, path: '../../centralid/omniauth-centralid'
gem 'identicon'
gem 'rack-cors', require: 'rack/cors'
gem 'hirb'
gem 'ffaker'
gem 'six'
gem 'pg_search', '~> 1.0.2'
gem 'kaminari', '~> 1.0.0.alpha', github: 'amatsuda/kaminari'
gem 'sinatra', '~> 2.0.0-alpha', github: 'sinatra/sinatra', require: nil # required to access sidekiq UI
gem 'rack-protection', '~> 2.0', github: 'sinatra/rack-protection'
gem 'sidekiq', '~> 4.1'
gem 'record_tag_helper', '~> 1.0'

group :test do
  gem 'minitest-rails-capybara'
  gem 'minitest-reporters'
  gem 'rails-controller-testing'
end

group :development do
  gem 'rack-mini-profiler'
  gem 'letter_opener'
  gem 'better_errors', '~> 2.0'
  gem 'web-console'
  gem 'binding_of_caller'
  gem 'listen', '~> 3.0.5'
  gem 'rails-erd'
  gem 'byebug', platform: :mri
  gem 'capistrano', '~> 2.15.5'
  gem 'foreman', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'exception_notification', '~> 4.0.0'
  gem 'unicorn'
  gem 'rails_12factor'
end
