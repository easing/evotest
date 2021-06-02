# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'

class UpdateDomainJobTest < ActiveJob::TestCase
  test 'should call UpdateDomainStatus operation on perform' do
    Domain.create(hostname: TEST_HOST)

    mock = Minitest::Mock.new
    mock.expect :call, nil, [TEST_HOST]

    UpdateDomainStatus.stub(:call, mock) do
      UpdateDomainStatusJob.perform_now(TEST_HOST)
    end

    assert_mock mock
  end
end
