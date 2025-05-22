require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Agazon
  class Application < Rails::Application
    # Load application's model / class decorators
    initializer 'spree.decorators' do |app|
      config.to_prepare do
        Dir.glob(Rails.root.join('app/**/*_decorator*.rb')) do |path|
          require_dependency(path)
        end
      end
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.exceptions_app = self.routes

    if Rails.env.production?
      Dir.glob(Rails.root.join('/**/solidus_volume_pricing*/**/*_decorator*.rb')) do |c|
        Rails.autoloaders.main.ignore(c)
      end
    end

    Rails.autoloaders.main.ignore(Dir.glob(Rails.root.join('app/decorators/controllers/spree/checkout_controller_decorator.rb'))[0])
    Rails.autoloaders.main.ignore(Dir.glob(Rails.root.join('app/decorators/models/spree/api/api_helpers_decorator.rb'))[0])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Solidus Tax cloud configuration
    TaxCloud.configure do |config|
      config.api_login_id = ENV['TAXCLOUD_API_ID']
      config.api_key = ENV['TAXCLOUD_API_KEY']
    end
  end
end

# touched on 2025-05-22T23:41:51.938925Z
# touched on 2025-05-22T23:48:32.926066Z