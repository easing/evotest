# frozen_string_literal: true

require 'test_helper'

class SidekiqAuthTest < ActionDispatch::IntegrationTest
  test 'sidekiq dashboard should require auth' do
    get sidekiq_web_path
    assert_response :unauthorized
  end

  test 'sidekiq dashboard should be accessible with username and password' do
    userpass = "#{ENV['DASHBOARD_USER']}:#{ENV['DASHBOARD_PASSWORD']}"
    auth_headers = { 'Authorization' => "Basic #{Base64.encode64(userpass)}" }

    get sidekiq_web_path, headers: auth_headers
    assert_response :success
  end
end
