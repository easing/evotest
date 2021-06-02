# frozen_string_literal: true

# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  hostname    :string           not null
#  status_type :enum             not null
#  message     :string           not null
#  current     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  include Shoulda::Matchers::ActiveModel
  include Shoulda::Matchers::ActiveRecord

  subject do
    Status.create(hostname: TEST_HOST, status_type: 'success', message: 'ok', current: true)
  end

  should validate_presence_of :hostname
  should validate_presence_of :message

  should define_enum_for(:status_type).with_values({ success: 'success', error: 'error' })
                                      .backed_by_column_of_type(:enum)

  should belong_to(:domain).class_name('Domain')
                           .without_validating_presence
                           .with_primary_key(:hostname)
                           .with_foreign_key(:hostname)

  test 'should not change persisted status' do
    status = CreateStatus.call(TEST_HOST, status_type: Status::SUCCESS, message: 'persisted')
    assert_equal Status::SUCCESS, status.status_type

    assert_raises ActiveRecord::ReadOnlyRecord do
      status.update(status_type: Status::ERROR)
    end

    assert_equal Status::SUCCESS, status.reload.status_type
  end
end
