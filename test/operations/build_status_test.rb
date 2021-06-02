# frozen_string_literal: true

require 'test_helper'

class BuildStatusTest < ActiveSupport::TestCase
  test 'should return error if not valid' do
    status, message = BuildStatus.call(false, 'error message', OpenSSL::X509::Certificate.new)
    assert_equal Status::ERROR, status
    assert_equal 'error message', message
  end

  test 'should return error if cert missed' do
    status, message = BuildStatus.call(true, 'test message', nil)
    assert_equal Status::ERROR, status
    assert_equal I18n.t('status.missed'), message
  end

  test 'should return error if will  expire in 1 week' do
    cert = OpenSSL::X509::Certificate.new
    cert.not_after = 6.days.from_now
    status, message = BuildStatus.call(true, nil, cert)
    assert_equal Status::ERROR, status
    assert_equal I18n.t('status.expire_in_1_week'), message
  end

  test 'should return error if will expire in 2 week' do
    cert = OpenSSL::X509::Certificate.new
    cert.not_after = 13.days.from_now
    status, message = BuildStatus.call(true, nil, cert)
    assert_equal Status::ERROR, status
    assert_equal I18n.t('status.expire_in_2_weeks'), message
  end
end
