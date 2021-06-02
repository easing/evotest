# frozen_string_literal: true

require 'test_helper'

module Resources
  class DomainTest < ActionDispatch::IntegrationTest
    test 'should create domain' do
      assert_difference('::Domain.count') do
        post domain_path, params: {
          hostname: TEST_HOST
        }
      end

      assert_response :success

      domain = ::Domain.last
      assert_equal TEST_HOST, domain.hostname
    end

    test 'should validate' do
      assert_no_difference('::Domain.count') do
        post domain_path, params: {
          hostname: INVALID_HOST
        }
      end

      assert_response :bad_request

      res = JSON.parse(response.body)
      assert_not_nil res['errors']
    end
  end
end
