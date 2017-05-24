require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Logcamp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.generators do |g|
      g.stylesheets  false
      g.javascripts  false
      g.helper       false
      g.test_framework :minitest, spec: true
    end

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
