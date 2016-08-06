require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Logcamp
  class Application < Rails::Application
    config.generators do |g|
      g.stylesheets  false
      g.javascripts  false
      g.helper       false
      g.test_framework :minitest, spec: true
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{config.root}/lib)

    config.assets.paths << "#{Rails.root}/app/assets/fonts"

    config.middleware.use Rack::Cors, logger: (-> { Rails.logger }) do
      allow do
        origins '*'
        resource '/api/*', headers: :any,
          methods: [:get, :post, :options], credentials: true, max_age: 0
      end
    end

  end
end
