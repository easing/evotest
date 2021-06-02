# frozen_string_literal: true

require 'test_helper'

class DocsControllerTest < ActionDispatch::IntegrationTest
  test 'should get swagger docs at root' do
    get root_path
    assert_response :success
  end
end
