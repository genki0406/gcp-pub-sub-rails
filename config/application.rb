require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pubsub
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.active_job.queue_adapter = :pub_sub_queue
    config.autoload_paths << Rails.root.join('lib')
    config.x.settings = Rails.application.config_for :settings
    if Dir.exist?('/var/log/app_engine/custom_logs')
      config.logger = ActiveSupport::TaggedLogging.new Logger.new('/var/log/app_engine/custom_logs/application.log')
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
