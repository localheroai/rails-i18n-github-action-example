require_relative "boot"

require "rails"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module TeamSettingsExample
  class Application < Rails::Application
    config.load_defaults 8.1

    config.i18n.available_locales = %i[en sv pl de]
    config.i18n.default_locale = :en
  end
end
