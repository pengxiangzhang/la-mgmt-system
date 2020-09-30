require_relative 'boot'

require 'rails/all'
require 'rack-cas'
require 'rack-cas/session_store/active_record'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module La
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.rack_cas.server_url = 'https://shib.unl.edu/idp/profile/cas'
    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.time_zone_aware_types = [:datetime]
    config.active_record.default_timezone = :local
    config.rack_cas.session_store = RackCAS::ActiveRecordStore

    # config.rack_cas.exclude_path='/home'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
