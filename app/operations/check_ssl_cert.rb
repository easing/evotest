# frozen_string_literal: true

##
# Проверяет SSL-сертификат
class CheckSSLCert
  # Проверяет SSL-сертификат на валидность
  # `valid, error, cert = test_ssl_cert(hostname)`
  #
  # @param [String] hostname
  # @return [[TrueClass|FalseClass, String|nil, OpenSSL::X509::Certificate|nil]]
  def self.call(hostname)
    SSLTest.test "https://#{hostname}"
  end
end
