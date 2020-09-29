require_relative 'boot'

require 'rails/all'
require 'rack-cas'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require 'rack-cas/session_store/active_record'

module Sso
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.rack_cas.server_url = 'https://cse-apps.unl.edu/cas'
    config.rack_cas.exclude_path='/auth'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
