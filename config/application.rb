# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module Evotest
  ##
  class Application < Rails::Application
    config.load_defaults 6.1

    config.api_only = true

    config.active_job.queue_adapter = :sidekiq

    # Sessions required by Sidekiq::Web dashboard
    config.session_store :cookie_store, key: '_evotest_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
  end
end
