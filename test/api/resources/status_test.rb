# frozen_string_literal: true

require 'test_helper'

module Resources
  class JournalTest < ActionDispatch::IntegrationTest
    test 'should get status' do
      get status_path
      assert_response :success
    end
  end
end
