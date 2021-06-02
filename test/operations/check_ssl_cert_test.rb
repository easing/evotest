# frozen_string_literal: true

require 'test_helper'

class CheckSSLCertTest < ActiveSupport::TestCase
  test 'should test valid ssl certificate' do
    valid, error, cert = CheckSSLCert.call(TEST_HOST)
    assert valid
    assert_nil error
    assert_instance_of OpenSSL::X509::Certificate, cert
  end

  test 'should return error for bad certificate' do
    %w[expired wrong.host self-signed untrusted-root].each do |host|
      valid, error, cert = CheckSSLCert.call("#{host}.#{TEST_HOST}")
      assert_not valid
      assert_not_empty error
      assert_instance_of OpenSSL::X509::Certificate, cert
    end
  end

  test 'should return error on request failure' do
    valid, error, cert = CheckSSLCert.call(INVALID_HOST)
    assert_not valid
    assert_not_empty error
    assert_nil cert
  end
end
