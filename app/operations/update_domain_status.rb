# frozen_string_literal: true

##
# Обновляет состояние домена
#
# 1. Проверяет наличие указанного хоста в базе
# 2. Получает информацию о текущем состоянии ssl-сертификата
# 3. Запускает создание записи в журнале состояний
class UpdateDomainStatus
  # @param [string] hostname
  # @return [Status]
  def self.call(hostname)
    domain = Domain.find_by(hostname: hostname)
    raise ArgumentError, "Unknown domain provided #{hostname}" unless domain

    valid, error, cert = CheckSSLCert.call(hostname)
    status_type, message = BuildStatus.call(valid, error, cert)

    CreateStatus.call(hostname, status_type: status_type, message: message)
  end
end
