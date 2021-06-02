# frozen_string_literal: true

require 'test_helper'

class CreateDomainTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test 'should create domain' do
    assert_difference('Domain.count') do
      CreateDomain.call(TEST_HOST)
    end
  end

  test 'should not create domain twice' do
    CreateDomain.call(TEST_HOST)

    assert_no_difference('Domain.count') do
      CreateDomain.call(TEST_HOST)
    end
  end

  test 'should mark domain as readonly' do
    domain = CreateDomain.call(TEST_HOST)
    assert domain.persisted?
    assert domain.readonly?
  end

  test 'should enqueue UpdateDomainJob' do
    assert_enqueued_jobs 1, only: UpdateDomainStatusJob do
      domain = CreateDomain.call(TEST_HOST)
      assert domain.persisted?
    end

    assert_enqueued_jobs 0, only: UpdateDomainStatusJob do
      domain = CreateDomain.call(INVALID_HOST)
      assert_not domain.persisted?
    end
  end

  test 'should not enqueue UpdateDomainJob for unsaved domains' do
    assert_enqueued_jobs 0, only: UpdateDomainStatusJob do
      domain = CreateDomain.call(INVALID_HOST)
      assert_not domain.persisted?
    end
  end
end
