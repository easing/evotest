# frozen_string_literal: true

TEST_HOST = 'badssl.com'
INVALID_HOST = ''

require 'simplecov'
SimpleCov.start 'rails' do
  add_group 'Api', 'app/api'
  add_group 'Operations', 'app/operations'
  add_group 'Validators', 'app/validators'
end

ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'
require 'rails/test_help'

Rails.application.eager_load!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :active_support_test_case
    with.library :rails
  end
end

module ActiveSupport
  class TestCase
    fixtures :all
  end
end

module ActionDispatch
  class IntegrationTest
    include GrapeRouteHelpers::NamedRouteMatcher
  end
end
