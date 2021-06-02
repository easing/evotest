# frozen_string_literal: true

# Разбирает ответ SSLTest и определяет состояние сертификата
class BuildStatus
  # @param [TrueClass|FalseClass] valid
  # @param [String|nil] message
  # @param [OpenSSL::X509::Certificate|nil] cert
  # @return [[String, String]] [status_type, message]
  def self.call(valid, message, cert)
    return [Status::ERROR, message] unless valid
    return [Status::ERROR, I18n.t('status.missed')] unless cert

    return [Status::ERROR, I18n.t('status.expire_in_1_week')] if cert.not_after < 1.week.from_now
    return [Status::ERROR, I18n.t('status.expire_in_2_weeks')] if cert.not_after < 2.weeks.from_now

    [Status::SUCCESS, message.present? ? message : I18n.t('status.valid')]
  end
end
