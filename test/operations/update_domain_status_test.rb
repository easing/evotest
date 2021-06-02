# frozen_string_literal: true

require 'test_helper'

class UpdateDomainStatusTest < ActiveSupport::TestCase
  test 'should validate hostname presence in database' do
    assert_raises ArgumentError do
      UpdateDomainStatus.call('not.exists.com')
    end
  end

  test 'should create current status' do
    assert_not Domain.exists?

    domain = Domain.create(hostname: TEST_HOST)

    assert_difference('Status.count') do
      UpdateDomainStatus.call(TEST_HOST)
      assert_not_nil domain.status
    end
  end
end
