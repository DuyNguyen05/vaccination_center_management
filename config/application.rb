require_relative 'boot'

require 'rails/all'
require 'wicked_pdf'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VaccinationCenterManagement
  class Application < Rails::Application
    config.time_zone = 'Hanoi'
    config.active_record.default_timezone = :local
    config.action_view.embed_authenticity_token_in_remote_forms = true
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.assets.paths << Rails.root.join("app", "assets", "fonts", "webfonts")
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag
    }
    config.middleware.use WickedPdf::Middleware
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
