source 'https://rubygems.org'

ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0rc2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc


gem 'simple_form', '~> 3.1.0'
gem 'nested_form'
gem 'tabs_on_rails', '~> 2.1.1'
gem 'thin'
gem 'figaro', '~> 1.0.0', github: 'laserlemon/figaro'
gem 'sorcery', github: 'NoamB/sorcery', ref: 'ef00bc866d315759470d05d0113b0d69f6cb80f2'
gem 'omniauth'
gem 'omniauth-github'
gem 'identicon'
gem 'rack-cors', require: 'rack/cors'
gem 'hirb'
gem 'ffaker'
gem 'six'
gem 'pg_search', '~> 0.7.8'
gem 'kaminari', '~> 1.0.0.alpha', github: 'amatsuda/kaminari'
gem 'delayed_job',                '~> 4.0.3'
gem 'delayed_job_active_record',  '~> 4.0.2'
gem 'i18n-js'

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'database_cleaner', '~> 1.3.0'
end

group :development do
  gem 'spring'
  gem 'rack-mini-profiler'
  gem 'letter_opener'
  gem 'better_errors', '~> 2.0'
  gem 'web-console', '~> 2.0'
  gem 'rails-erd'
  gem 'byebug'
  gem 'capistrano', '~> 3.3.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-nc', '~> 0.1'
  # gem 'i18n-debug'
end

group :production do
  gem 'exception_notification', '~> 4.0.0'
  gem 'unicorn'
  gem 'rails_12factor'
end
