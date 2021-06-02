# frozen_string_literal: true

require 'test_helper'

module Resources
  class JournalTest < ActionDispatch::IntegrationTest
    test 'should get journal' do
      get journal_path
      assert_response :success
    end

    test 'should filter journal with ransack queries' do
      CreateStatus.call('1.example.com', status_type: ::Status::ERROR, message: ':(')
      CreateStatus.call('2.example.com', status_type: ::Status::ERROR, message: ':(')

      get journal_path
      assert_response :success
      assert_equal 2, JSON.parse(response.body).size

      get journal_path, params: { query: { hostname_eq: '1.example.com' } }
      assert_response :success
      assert_equal 1, JSON.parse(response.body).size
    end
  end
end
