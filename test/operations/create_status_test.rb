# frozen_string_literal: true

require 'test_helper'

class CreateStatusTest < ActiveSupport::TestCase
  test 'should update existing current status if no difference with new status' do
    assert_difference('Status.count', 1) do
      status1 = CreateStatus.call(TEST_HOST, status_type: Status::SUCCESS, message: 'OK')
      status1_updated_at = status1.updated_at

      status2 = CreateStatus.call(TEST_HOST, status_type: Status::SUCCESS, message: 'OK')
      assert_equal status1, status2

      assert_not_equal status1_updated_at, status1.reload.updated_at
    end
  end

  test 'should create new status if domain has not current status' do
    assert_difference('Status.count', 1) do
      status1 = CreateStatus.call(TEST_HOST, status_type: Status::SUCCESS, message: 'OK')
      status2 = CreateStatus.call(TEST_HOST, status_type: Status::SUCCESS, message: 'OK')

      assert status1.current?
      assert_equal status1, status2
    end
  end

  test 'should create new status if has difference with current status' do
    status1 = CreateStatus.call(TEST_HOST, status_type: Status::SUCCESS, message: 'OK')
    status2 = CreateStatus.call(TEST_HOST, status_type: Status::SUCCESS, message: 'OK1')

    assert_not_equal status1, status2
    assert_not status1.reload.current?
    assert status2.reload.current?
  end
end
