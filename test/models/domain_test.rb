# frozen_string_literal: true

# == Schema Information
#
# Table name: domains
#
#  id         :bigint           not null, primary key
#  hostname   :string           not null
#  created_at :datetime         not null
#
require 'test_helper'

class DomainTest < ActiveSupport::TestCase
  include Shoulda::Matchers::ActiveModel
  include Shoulda::Matchers::ActiveRecord

  subject do
    Domain.create(hostname: TEST_HOST)
  end

  should have_many(:statuses).class_name('Status')
  should have_one(:status).class_name('Status')

  should validate_presence_of(:hostname)
  should validate_uniqueness_of(:hostname)
  should allow_value(TEST_HOST).for(:hostname)
  should_not allow_value(INVALID_HOST).for(:hostname)

  test 'should be marked as readonly' do
    domain = CreateDomain.call(TEST_HOST)

    assert_raises ActiveRecord::ReadOnlyRecord do
      domain.update(hostname: 'example.com')
    end
  end
end
